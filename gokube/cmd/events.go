package cmd

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"sort"
	"text/tabwriter"
)

type (
	metadataType struct {
		CreationTimestamp string `json:"creationTimestamp"`
	}
	involvedObjectType struct {
		Kind string `json:"kind"`
		Name string `json:"name"`
	}
	eventType struct {
		Metadata       metadataType       `json:"metadata"`
		InvolvedObject involvedObjectType `json:"involvedObject"`
		Message        string             `json:"message"`
		Reason         string             `json:"reason"`
		Type           string             `json:"type"`
	}
	eventsType struct {
		Items []eventType `json:"items"`
	}
)

func executeEventsCmd() {
	a := append([]string{"get", "events", "-o", "json"}, os.Args[2:]...)
	oscmd := exec.Command("kubectl", a...)
	oscmd.Stderr = os.Stderr
	var stdout bytes.Buffer
	oscmd.Stdout = &stdout
	err := oscmd.Run()
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}
	var m eventsType
	err = json.Unmarshal(stdout.Bytes(), &m)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}
	if len(m.Items) > 0 {
		sort.Slice(m.Items, func(i, j int) bool {
			return m.Items[i].Metadata.CreationTimestamp < m.Items[j].Metadata.CreationTimestamp
		})
		w := new(tabwriter.Writer)
		w.Init(os.Stdout, 5, 0, 2, ' ', 0)
		fmt.Fprintln(w, "TIME\tTYPE\tREASON\tOBJECT\tMESSAGE")
		for _, v := range m.Items {
			fmt.Fprintf(w, "%s\t%s\t%s\t%s/%s\t%s\n", v.Metadata.CreationTimestamp, v.Type, v.Reason, v.InvolvedObject.Kind, v.InvolvedObject.Name, v.Message)
		}
		fmt.Fprintln(w)
		w.Flush()
	} else {
		fmt.Println("No resources found")
	}
}

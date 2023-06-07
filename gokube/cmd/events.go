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
			if m.Items[i].InvolvedObject.Kind == m.Items[j].InvolvedObject.Kind {
				if m.Items[i].InvolvedObject.Name == m.Items[j].InvolvedObject.Name {
					return m.Items[i].Metadata.CreationTimestamp < m.Items[j].Metadata.CreationTimestamp
				}
				return m.Items[i].InvolvedObject.Name < m.Items[j].InvolvedObject.Name
			}
			return m.Items[i].InvolvedObject.Kind < m.Items[j].InvolvedObject.Kind
		})
		w := new(tabwriter.Writer)
		w.Init(os.Stdout, 5, 0, 2, ' ', 0)
		fmt.Fprintln(w, "OBJECT\tTIME\tTYPE\tREASON\tMESSAGE")
		for _, v := range m.Items {
			fmt.Fprintf(w, "%s/%s\t%s\t%s\t%s\t%s\n", v.InvolvedObject.Kind, v.InvolvedObject.Name, v.Metadata.CreationTimestamp, v.Type, v.Reason, v.Message)
		}
		fmt.Fprintln(w)
		w.Flush()
	} else {
		fmt.Println("No resources found")
	}
}

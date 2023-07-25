package cmd

import (
	"fmt"
	"os"
	"os/exec"
	"sort"
	"strings"
)

func executeAllCmd() {
	a := []string{"api-resources", "--verbs=list", "--namespaced=true", "-o", "name"}
	kcmd := exec.Command("kubectl", a...)
	kcmd.Stderr = os.Stderr
	stdout, err := kcmd.Output()
	if err != nil {
		fmt.Printf("%s\n", err)
		// return
	}
	split := strings.Split(string(stdout), "\n")
	filtered := make([]string, 0)
	for _, v := range split {
		if v != "" && !strings.Contains(v, "event") {
			filtered = append(filtered, v)
		}
	}
	sort.Strings(filtered)
	join := strings.Join(filtered, ",")
	a = append([]string{"get", "--show-kind", "--ignore-not-found"}, os.Args[2:]...)
	a = append(a, join)
	kcmd = exec.Command("kubectl", a...)
	kcmd.Stderr = os.Stderr
	kcmd.Stdout = os.Stdout
	if err = kcmd.Run(); err != nil {
		fmt.Printf("%s\n", err)
	}
}

package cmd

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

var cmds = map[string]func(){}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := addKubectlCmds(); err != nil {
		fmt.Printf("%v\n", err)
		return
	}
	cmds["all"] = executeAllCmd
	cmds["context"] = executeContextCmd
	cmds["ctx"] = executeContextCmd
	cmds["c"] = executeContextCmd
	cmds["events"] = executeEventsCmd
	cmds["event"] = executeEventsCmd
	cmds["ev"] = executeEventsCmd
	cmds["namespaces"] = executeNsCmd
	cmds["ns"] = executeNsCmd
	cmds["stratum"] = executeStratumConnectCmd
	cmds["str"] = executeStratumConnectCmd
	cmds["s"] = executeStratumConnectCmd

	if len(os.Args) > 1 {
		cmd, ok := cmds[os.Args[1]]
		if ok {
			cmd()
		} else {
			fmt.Printf("command %s not known", os.Args[1])
		}
	} else {
		fmt.Printf("usage: %s [cmd]\n%s\n", os.Args[0], keysString(cmds))
	}
}

func addKubectlCmds() error {
	cmd := exec.Command("kubectl", "help")
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	cmd.Stderr = os.Stderr
	// read command's output line by line
	outScanner := bufio.NewScanner(stdout)
	outFinished := make(chan bool)
	go func(outScanner *bufio.Scanner) {
		for outScanner.Scan() {
			t := outScanner.Text()
			if len(t) > 2 && t[0:2] == "  " {
				re := regexp.MustCompile(`\s+`)
				split := re.Split(t, -1)
				switch split[1] {
				case "delete":
					cmds[split[1]] = kubeCmd(split[1])
					cmds["del"] = cmds[split[1]]
					cmds["rm"] = cmds[split[1]]
				case "describe":
					cmds[split[1]] = kubeCmd(split[1])
					cmds["desc"] = cmds[split[1]]
				case "edit":
					cmds[split[1]] = kubeCmd(split[1])
					cmds["e"] = cmds[split[1]]
				case "kubectl":
				default:
					cmds[split[1]] = kubeCmd(split[1])
				}
			}
		}
		outFinished <- true
	}(outScanner)
	// start the command after having set up the pipe
	if err := cmd.Start(); err != nil {
		return err
	}
	if err := cmd.Wait(); err != nil {
		return err
	}
	<-outFinished
	return nil
}

func kubeCmd(cmd string) func() {
	return func() {
		kargs := []string{cmd}
		kargs = append(kargs, os.Args[2:]...)
		kcmd := exec.Command("kubectl", kargs...)
		kcmd.Stderr = os.Stderr
		kcmd.Stdout = os.Stdout
		if err := kcmd.Run(); err != nil {
			fmt.Printf("%s\n", err)
		}
	}
}
func keysString(m map[string]func()) string {
	keys := make([]string, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}
	return "[" + strings.Join(keys, ", ") + "]"
}

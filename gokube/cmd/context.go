package cmd

import (
	"fmt"
	"sort"
	"strings"

	"github.com/AlecAivazis/survey/v2"
	"k8s.io/client-go/tools/clientcmd"
)

func executeContextCmd() {
	kubeConfigPath, err := getKubeConfigPath()
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	config, err := getKubeConfigs(kubeConfigPath)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	opt := []string{}
	for n, c := range config.Contexts {
		opt = append(opt, fmt.Sprintf("%s - %s", c.AuthInfo, n))
	}
	sort.Strings(opt)
	var defaultCtx interface{} = nil
	if config.CurrentContext != "" {
		defaultCtx = fmt.Sprintf("%s - %s", config.Contexts[config.CurrentContext].AuthInfo, config.CurrentContext)
	}
	simpleQs := []*survey.Question{
		{
			Name: "context",
			Prompt: &survey.Select{
				Message: "Choose a context:",
				Options: opt,
				Default: defaultCtx,
			},
		},
	}
	answers := struct {
		Context string
	}{}
	// ask the question
	err = survey.Ask(simpleQs, &answers)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	config.CurrentContext = strings.Split(answers.Context, " - ")[1]
	err = clientcmd.WriteToFile(*config, kubeConfigPath)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	fmt.Printf("Switched to context %s.\n", config.CurrentContext)
}

func executeContextDeleteCmd() {
	kubeConfigPath, err := getKubeConfigPath()
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	config, err := getKubeConfigs(kubeConfigPath)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	opt := []string{}
	for n, c := range config.Contexts {
		opt = append(opt, fmt.Sprintf("%s - %s", c.AuthInfo, n))
	}
	sort.Strings(opt)
	simpleQs := []*survey.Question{
		{
			Name: "context",
			Prompt: &survey.Select{
				Message: "Choose a context:",
				Options: opt,
				Default: fmt.Sprintf("%s - %s", config.Contexts[config.CurrentContext].AuthInfo, config.CurrentContext),
			},
			// Validate: survey.Required,
		},
	}
	answers := struct {
		Context string
	}{}
	// ask the question
	err = survey.Ask(simpleQs, &answers)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	selCtxName := strings.Split(answers.Context, " - ")[1]
	ctx := config.Contexts[selCtxName]
	delete(config.Clusters, ctx.Cluster)
	delete(config.AuthInfos, ctx.AuthInfo)
	delete(config.Contexts, selCtxName)
	config.CurrentContext = ""
	err = setKubeConfigs(config, kubeConfigPath)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Printf("Context %s deleted.\n", selCtxName)
}

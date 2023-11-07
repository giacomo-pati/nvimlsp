package cmd

import (
	"context"
	"fmt"
	"sort"

	"github.com/AlecAivazis/survey/v2"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/utils/strings/slices"
)

func executeNsCmd() {
	kubeConfigPath, err := getKubeConfigPath()
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	apiconfig, err := getKubeConfigs(kubeConfigPath)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	// use the current context in kubeconfig
	restconfig, err := clientcmd.BuildConfigFromFlags("", kubeConfigPath)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	// create the clientset
	clientset, err := kubernetes.NewForConfig(restconfig)
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	ns, err := clientset.CoreV1().Namespaces().List(context.Background(), metav1.ListOptions{})
	if err != nil {
		fmt.Printf("%v\n", err)
		return
	}

	namespaces := []string{}
	for _, v := range ns.Items {
		namespaces = append(namespaces, v.ObjectMeta.Name)
	}
	sort.Strings(namespaces)
	defaultNs := "default"
	ctxNs := apiconfig.Contexts[apiconfig.CurrentContext].Namespace
	if ctxNs != "" && slices.Contains(namespaces, ctxNs) {
		defaultNs = apiconfig.Contexts[apiconfig.CurrentContext].Namespace
	}
	simpleQs := []*survey.Question{
		{
			Name: "namespace",
			Prompt: &survey.Select{
				Message: "Choose a namespace:",
				Options: namespaces,
				Default: defaultNs,
			},
			// Validate: survey.Required,
		},
	}
	answers := struct {
		Namespace string
	}{}

	// ask the question
	err = survey.Ask(simpleQs, &answers)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	apiconfig.Contexts[apiconfig.CurrentContext].Namespace = answers.Namespace
	err = clientcmd.WriteToFile(*apiconfig, kubeConfigPath)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	fmt.Printf("Context %s pinned to namespace %s\n", apiconfig.CurrentContext, answers.Namespace)
}

package cmd

import (
	"bufio"
	"context"
	"errors"
	"fmt"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"sort"
	"strings"

	"github.com/AlecAivazis/survey/v2"
	graph "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/resourcegraph/armresourcegraph"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/tools/clientcmd/api"
)

type (
	stratumInfo struct {
		aksEnvironments []aksEnvironmentType
	}

	aksEnvironmentType struct {
		AksName            string
		SubscriptionID     string
		ResourceGroup      string
		StratumClusterName string
	}
)

func executeStratumConnectCmd() {
	sInfo := stratumInfo{}
	sInfo.fetchStratumClusters()
	var env *aksEnvironmentType
	if false {
		env = &sInfo.aksEnvironments[0]
	} else {
		env = sInfo.askForStratumEnv()
	}
	sInfo.connect(env)
}

func (info *stratumInfo) askForStratumEnv() *aksEnvironmentType {
	targets := []string{}
	for _, v := range info.aksEnvironments {
		if len(v.StratumClusterName) > 13 {
			targets = append(targets, fmt.Sprintf("%s\t%s\t%s", v.StratumClusterName, v.AksName, v.ResourceGroup))
		} else {
			targets = append(targets, fmt.Sprintf("%s\t\t%s\t%s", v.StratumClusterName, v.AksName, v.ResourceGroup))
		}
	}
	sort.Strings(targets)

	s := survey.Select{
		Message: "Choose a target STRATUM environment or press ctrl-c to cancel selection:",
		Options: targets,
	}
	simpleQs := []*survey.Question{{
		Name:   "environment",
		Prompt: &s,
	}}
	answers := struct {
		Environment string
	}{}
	// ask the question
	err := survey.Ask(simpleQs, &answers)
	if err != nil {
		log.Fatalf("Selection canceled: %v", err)
	}
	if answers.Environment == "" {
		log.Fatal("Answer has no Environment")
	}
	log.Printf("Environment selected: '%v'", answers.Environment)

	selection := strings.Split(answers.Environment, "\t")[0]
	for _, v := range info.aksEnvironments {
		if strings.EqualFold(selection, v.StratumClusterName) {
			return &v
		}
	}
	log.Fatalf("Env '%s' not found, this should not happen", answers.Environment)
	return nil
}
func (info *stratumInfo) fetchStratumClusters() {
	// Create and authorize a ResourceGraph client
	graphClient := graph.New()
	authorizer, err := auth.NewAuthorizerFromCLI()
	if err != nil {
		log.Fatalf("cannot get authorization: %v", err)
	}
	graphClient.Authorizer = authorizer

	// Set options
	RequestOptions := graph.QueryRequestOptions{
		ResultFormat: "objectArray",
	}

	// Create the query request
	query := `
resources
 | where tags["APMID"] =~"AZAPPHOST"
     and not(isnull(tags["Instance"]))
	 and type == "microsoft.containerservice/managedclusters"
 | project aksName=name, subscriptionId, resourceGroup, stratumClusterName=tags["Instance"]
`
	Request := graph.QueryRequest{
		Subscriptions: &[]string{},
		Query:         &query,
		Options:       &RequestOptions,
	}

	// Run the query and get the results
	// TODO: Make this call to not block us as in the STRATUM Launch demo and
	// use an embedded cache
	results, err := graphClient.Resources(context.Background(), Request)
	if err != nil {
		log.Fatalf("cannot execute query: %v", err)
	}
	res := []aksEnvironmentType{}
	if r1, ok := results.Data.([]interface{}); ok {
		for _, v := range r1 {
			if r2, ok := v.(map[string]interface{}); ok {
				res = append(res, aksEnvironmentType{
					AksName:            r2["aksName"].(string),
					SubscriptionID:     r2["subscriptionId"].(string),
					ResourceGroup:      r2["resourceGroup"].(string),
					StratumClusterName: r2["stratumClusterName"].(string),
				})
			}
		}
	}
	sort.Slice(res, func(i, j int) bool {
		return res[i].StratumClusterName < res[j].StratumClusterName
	})
	lastName := ""
	i := 0
	for j, v := range res {
		if strings.EqualFold(v.StratumClusterName, lastName) {
			i++
			res[j].StratumClusterName = fmt.Sprintf("%s@%d", v.StratumClusterName, i)
		} else {
			lastName = v.StratumClusterName
			i = 0
		}
	}

	info.aksEnvironments = res
}
func (info *stratumInfo) connect(env *aksEnvironmentType) error {
	log.Printf("Connecting to environment %s", env.StratumClusterName)
	azargs := []string{"aks", "get-credentials", "--name", env.AksName, "--subscription", env.SubscriptionID,
		"--resource-group", env.ResourceGroup, "--overwrite-existing"}
	isAdmin := false
	for _, v := range os.Args[2:] {
		if strings.EqualFold(v, "--admin") || strings.EqualFold(v, "-a") {
			isAdmin = true
		}
		azargs = append(azargs, v)
	}
	kc := os.Getenv("KUBECONFIG")
	if kc != "" {
		azargs = append(azargs, "-f", kc)
	}
	err := execLogged("az", azargs...)
	if err != nil {
		log.Fatalf("failed to connect to environment %s: %v", env.StratumClusterName, err)
	}

	if !isAdmin {
		if kc == "" {
			kc = filepath.Join(userHomeDir(), ".kube", "config")
		}
		err = convertAPIConfig(kc)
		if err != nil {
			log.Fatalf("failed to connect to environment %s: %v", env.StratumClusterName, err)
		}
	}

	return nil
}

// ExecLogged executes a command with its output being piped to the standard logger
func execLogged(name string, args ...string) error {
	log.Printf("%s %s", name, strings.Join(args, " "))
	cmd := exec.Command(name, args...)
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	stderr, err := cmd.StderrPipe()
	if err != nil {
		return err
	}
	// start the command after having set up the pipe
	if err := cmd.Start(); err != nil {
		return err
	}
	// read command's output line by line
	outScanner := bufio.NewScanner(stdout)
	errScanner := bufio.NewScanner(stderr)
	outFinished := make(chan bool)
	errFinished := make(chan bool)
	go func() {
		for outScanner.Scan() {
			log.Println(outScanner.Text()) // write each line to your log, or anything you need
		}
		outFinished <- true
	}()
	go func() {
		for errScanner.Scan() {
			fmt.Fprintln(os.Stderr, errScanner.Text()) // write each line to your log, or anything you need
		}
		errFinished <- true
	}()
	if err := cmd.Wait(); err != nil {
		return err
	}
	<-outFinished
	<-errFinished
	return nil
}

// getAPIConfig returns a api.Config if possible or nilor an error
func getAPIConfig(kubeConfigPath string) (*api.Config, error) {
	_, err := os.Stat(kubeConfigPath)
	if err != nil && !errors.Is(err, fs.ErrNotExist) {
		return nil, err
	}
	if err != nil {
		// we have never connected to any Kubernetes cluster
		return nil, nil
	}
	loadingRules := &clientcmd.ClientConfigLoadingRules{ExplicitPath: kubeConfigPath}
	configOverrides := &clientcmd.ConfigOverrides{}
	kubeConfig := clientcmd.NewNonInteractiveDeferredLoadingClientConfig(loadingRules, configOverrides)
	config, err := kubeConfig.RawConfig()
	if err != nil {
		log.Fatalf("error getting RawConfig: %v", err)
	}
	return &config, nil
}

// convertAPIConfig converts a kubeconfig with existing azure auth provider format to
// exec credential plugin format in order to use the kubelogin plugin for
// azure authentication. See: https://github.com/Azure/kubelogin
func convertAPIConfig(kubeConfigPath string) error {
	config, err := getAPIConfig(kubeConfigPath)
	if err != nil {
		return err
	}

	for _, authInfo := range config.AuthInfos {
		if authInfo != nil {
			if authInfo.AuthProvider != nil && authInfo.AuthProvider.Name == "azure" && authInfo.AuthProvider.Config["apiserver-id"] != "" {
				authInfo.Exec = createExecArgs()
				authInfo.Exec.Args = append(authInfo.Exec.Args, authInfo.AuthProvider.Config["apiserver-id"])
				authInfo.AuthProvider = nil
			} else if authInfo.Exec != nil {
				for i, e := range authInfo.Exec.Args {
					if e == "--server-id" && (i+1) < len(authInfo.Exec.Args) {
						sid := authInfo.Exec.Args[i+1]
						authInfo.Exec = createExecArgs()
						authInfo.Exec.Args = append(authInfo.Exec.Args, sid)
						authInfo.AuthProvider = nil
						break
					}
				}
			}
		}
	}

	return clientcmd.ModifyConfig(clientcmd.NewDefaultPathOptions(), *config, true)
}

func createExecArgs() *api.ExecConfig {
	return &api.ExecConfig{
		Command: "kubelogin",
		Args: []string{
			"get-token",
			"--login",
			"azurecli",
			"--server-id",
		},
		APIVersion: "client.authentication.k8s.io/v1beta1",
	}
}

func userHomeDir() string {
	if runtime.GOOS == "windows" {
		home := os.Getenv("HOMEDRIVE") + os.Getenv("HOMEPATH")
		if home == "" {
			home = os.Getenv("USERPROFILE")
		}
		return home
	}
	return os.Getenv("HOME")
}

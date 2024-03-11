package cmd

import (
	"fmt"
	"os"
	"path/filepath"

	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/tools/clientcmd/api"
	"k8s.io/client-go/util/homedir"
)

func getKubeConfigPath() (string, error) {
	kubeconfig := os.Getenv("KUBECONFIG")
	if kubeconfig == "" {
		if home := homedir.HomeDir(); home != "" {
			kubeconfig = filepath.Join(home, ".kube", "config")
		} else {
			return "", fmt.Errorf("no 'home' directory found")
		}
	}
	return kubeconfig, nil
}

func getKubeConfigs(kubeConfigPath string) (*api.Config, error) {
	loadingRules := &clientcmd.ClientConfigLoadingRules{ExplicitPath: kubeConfigPath}
	configOverrides := &clientcmd.ConfigOverrides{}

	kubeConfig := clientcmd.NewNonInteractiveDeferredLoadingClientConfig(loadingRules, configOverrides)
	config, err := kubeConfig.RawConfig()
	if err != nil {
		return nil, fmt.Errorf("error getting RawConfig: %w", err)
	}
	return &config, nil
}

func setKubeConfigs(api *api.Config, kubeConfigPath string) error {
	err := clientcmd.WriteToFile(*api, kubeConfigPath)
	if err != nil {
		return fmt.Errorf("error writing kubeconfig: %v", err)
	}
	return nil
}

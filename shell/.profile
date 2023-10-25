#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    test -f "$HOME/.bashrc" && . "$HOME/.bashrc"
fi

mkdir -p $HOME/.profile_paths

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  echo "$HOME/bin" >$HOME/.profile_paths/home_bin.path
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  echo "$HOME/local/bin" >$HOME/.profile_paths/home_local_bin.path
fi

# set M2 home if exists
if [ -d "/opt/maven" ] ; then
  export M2_HOME=/opt/maven
fi

export AZURE_ACCOUNT="AZAPPHOST DEV CONNECTED 2"
echo "setting Azure Account to '${AZURE_ACCOUNT}'"
az account set -s "AZAPPHOST DEV CONNECTED 2"
AZURE_SUBSCRIPTION_ID=$(az account show|jq -r ".id")
export AZURE_SUBSCRIPTION_ID
export ARM_DISABLE_PULUMI_PARTNER_ID=true
export ARM_USE_MSI=true
export AZURE_STORAGE_ACCOUNT=aah2sapulumi
export AZURE_STORAGE_RESOURCE_GROUP=pulumi

if [ ! -f "$HOME/.cache/AAH_SECRETS_KEYVAULT" ] ; then
  echo "refreshing secrets keyvault name to '$HOME/.cache/AAH_SECRETS_KEYVAULT'"
  az resource list -g security-zone --resource-type Microsoft.KeyVault/vaults --query '[0].name' -o tsv --subscription "$AZURE_ACCOUNT" > "$HOME/.cache/AAH_SECRETS_KEYVAULT"
else
  echo "reusing secrets keyvault name from '$HOME/.cache/AAH_SECRETS_KEYVAULT'"
fi
AZURE_SECRETS_KEYVAULT=$(cat "$HOME/.cache/AAH_SECRETS_KEYVAULT")
export AZURE_SECRETS_KEYVAULT
AAH_SECRETS_KEYVAULT=$AZURE_SECRETS_KEYVAULT
export AAH_SECRETS_KEYVAULT

if [ ! -f "$HOME/.cache/PULUMI_KEYVAULT" ] ; then
  echo "refreshing pulumi keyvault name to '$HOME/.cache/PULUMI_KEYVAULT'"
  az resource list -g pulumi --resource-type Microsoft.KeyVault/vaults --query '[0].name' -o tsv --subscription "$AZURE_ACCOUNT" > "$HOME/.cache/PULUMI_KEYVAULT"
else
  echo "reusing pulumi keyvault name from '$HOME/.cache/PULUMI_KEYVAULT'"
fi
PULUMI_KEYVAULT=$(cat "$HOME/.cache/PULUMI_KEYVAULT")
export PULUMI_KEYVAULT

if [ ! -f "$HOME/.cache/AZURE_STORAGE_KEY" ] ; then
  echo "refreshing storage access key for SA '${AZURE_STORAGE_RESOURCE_GROUP}/${AZURE_STORAGE_ACCOUNT} to '$HOME/.cache/AZURE_STORAGE_KEY'"
  az storage account keys list --resource-group $AZURE_STORAGE_RESOURCE_GROUP --account-name $AZURE_STORAGE_ACCOUNT --query '[0].value' -o tsv > "$HOME/.cache/AZURE_STORAGE_KEY"
  chmod 0600 "$HOME/.cache/AZURE_STORAGE_KEY"
else
  echo "reusing storage access key for SA '${AZURE_STORAGE_RESOURCE_GROUP}/${AZURE_STORAGE_ACCOUNT} from '$HOME/.cache/AZURE_STORAGE_KEY'"
fi
AZURE_STORAGE_KEY=$(cat "$HOME/.cache/AZURE_STORAGE_KEY")
export AZURE_STORAGE_KEY

if [ ! -f "$HOME/.cache/CF_API_TOKEN" ] ; then
  echo "refreshing CloudFlare API token from KeyVault '${AAH_SECRETS_KEYVAULT}/cf-token' to '$HOME/.cache/CF_API_TOKEN'"
  az keyvault secret show --id https://${AAH_SECRETS_KEYVAULT}.vault.azure.net/secrets/cf-token --query value -o tsv > "$HOME/.cache/CF_API_TOKEN"
else
  echo "reusing CloudFlare API token of KeyVault '${AAH_SECRETS_KEYVAULT}/cf-token' from '$HOME/.cache/CF_API_TOKEN'"
fi
CF_API_TOKEN=$(cat "$HOME/.cache/CF_API_TOKEN")
export CF_API_TOKEN
CLOUDFLARE_API_TOKEN=$CF_API_TOKEN
export CLOUDFLARE_API_TOKEN

export PULUMI_ACCESS_TOKEN="..."
export PULUMI_SECRET_PROVIDER=azurekeyvault://${PULUMI_KEYVAULT}.vault.azure.net/keys/azapphost

if [ -f "$HOME/.profile_paths" ] ; then
  . "$HOME/.profile_paths"
fi
if [ -n "$BASH_VERSION" ]; then
    eval "$(stratum completion zsh)"
    eval "$(pulumi gen-completion zsh)"
    eval "$(zoxide init zsh)"
    eval "$(kubectl completion zsh)"
    eval "$(stern --completion zsh)"
    complete -o default -F __start_stratum s
    complete -o default -F __start_kubectl k
    complete -o default -F __start_pulumi pu
fi

alias s="stratum"
alias k="kubectl"
alias kall="gk all"
alias kev="gk ev"
alias kns="gk ns"
alias kc="gk c"
alias kcd="gk cd"
alias ks="gk s"
alias pu=pulumi
function plss {
    pulumi stack ls | grep -v "LAST UPDATE" | awk '{split($1,a,"-"); print a[length(a)] " " $0}' | tr -d '*' | sort -k 1 | awk '/BEGIN/ {a=""} {if(a!=$1){print ""};a=$1; print substr($0,length($1)+2)}'
}

function pl {
	local argsx="--color never --non-interactive --logtostderr"
	local command=$1
	shift
	case $command in
	    up)
		    local argsy="--refresh --yes --skip-preview"
		    ;;
	    pre)
		    local argsy="--refresh"
		    ;;
	    preview)
		    local argsy="--refresh"
		    ;;
	    refresh)
		    local argsy="--yes --skip-preview"
		    ;;
	    destroy)
		    local argsy="--refresh --yes --skip-preview"
		    ;;
	    *)
		    local argsy=""
		    ;;
	esac
	echo "Executing pulumi $command $* $argsx $argsy"
	cmd="pulumi $command $* $argsx $argsy"
	eval "$cmd"
}

export PATH=$PATH:$(find ~/.profile_paths -name \*.path -print0 | xargs -0 cat | tr '\n' ':')

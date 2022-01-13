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
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH=$PATH:/home/giacomo/.cargo/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

export ARM_DISABLE_PULUMI_PARTNER_ID=true
export ARM_USE_MSI=true
export AZURE_STORAGE_ACCOUNT=aahdsapulumi
export AZURE_STORAGE_KEY="+zjWzqZq5hAFX8YE/AkvcQoCWSycJgSloqig5rlBiCt4uPcaCu+UE9hD0S/bOosSvF6uZfWSmAgYqsSsqvQtUg=="
export PULUMI_ACCESS_TOKEN=pul-d17432f4bd47c776de688a7bfc03ae69b0d4b2a0
export PULUMI_SECRET_PROVIDER=azurekeyvault://aah-d-kv-pulumi.vault.azure.net/keys/azapphost

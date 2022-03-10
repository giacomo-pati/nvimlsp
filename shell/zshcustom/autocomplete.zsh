# source <(kubectl completion zsh) # provided by zsh plugin
# source <(zoxide init zsh) # provided by zsh plugin
source <(stratum completion zsh)
compdef _stratum stratum # for whatever reason this seems to be needed to make it work
source <(pulumi gen-completion zsh)

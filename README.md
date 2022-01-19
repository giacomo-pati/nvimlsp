# nvimdotfiles

Neovim configuration system

## Installation of Prereqs on WSL/Ubuntu (system level)

- WSL: Install "Ubuntu 20.04 LTS"
- open shell and execute the following commands:

```bash
    sudo sh -c "echo $USER ALL=\(ALL\) NOPASSWD:ALL >>/etc/sudoers.d/$USER" # to allow using 'sudo' without a password
    sudo su -
    vi /etc/update-manager/release-upgrades # change `Prompt=normal`
```

- execute the following commands to upgrade to Ubuntu 21.04:

```bash
    apt install update-manager-core
    apt purge snapd -y # it will otherwise prevent do-release-upgrade
    apt update
    apt upgrade -y
    do-release-upgrade # if it fails, skip it, follow instaructions: for Mail config chose "No configuration"
    apt install snapd -y # reinstall to make MS happy
```

- if you want to stay on 20.04 do the following:

```bash
    apt update
    apt upgrade -y
```

- exit and repoen shell
- execute the following commands to install Neovim universe:

```bash
    add-apt-repository ppa:neovim-ppa/stable # or unstable as you like
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    apt update
    apt install -y neovim python3-dev python3-pip nodejs ruby-full cpanminus \
        luarocks sqlite3 locate ripgrep fd-find daemonize dbus-user-session \
        fontconfig dos2unix shellcheck cargo black flake8 default-jdk \
        apt-transport-https
    pip3 install --upgrade pynvim msgpack
    npm install -g npm@latest neovim@latest @fsouza/prettierd@latest eslint_d@latest
    gem install neovim
    snap install glow
```

- exit all shells completely!

## Installation of Prereqs on WSL/Ubuntu (user level)

- open shell and execute the following commands:

```bash
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    mkdir -p ~/.fonts
    unzip JetBrainsMono.zip -d ~/.fonts
    rm JetBrainsMono.zip
    fc-cache -fv
    # cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5 -Mlocal::lib)
    cargo install stylua
    curl -sS https://webinstall.dev/zoxide | bash
```

- Make sure the following environment variables get set next time you login by executing:

```bash
    #echo export PERL5LIB=/home/giacomo/perl5/lib/perl5 >>~/.profile
    #echo export PERL_LOCAL_LIB_ROOT=/home/giacomo/perl5 >>~/.profile
    #echo export PERL_MB_OPT=\"--install_base /home/giacomo/perl5\" >>~/.profile
    #echo export PERL_MM_OPT=INSTALL_BASE=/home/giacomo/perl5 >>~/.profile
    echo export PATH=\$PATH:$HOME/.cargo/bin >>~/.profile
```

- exit all shells completely!

## Installation of this Neovim configuration

- open shell and execute the following commands:

```bash
    mkdir -p ~/.config
    rm -rf ~/.local/share/nvim/ ~/.config/nvim/ ~/.cache/nvim/
    cp -a [PATH-TO-THIS-REPO-CHECKOUT]/nvim ~/.config/
    nvim # this will install all plugins
```

- Quit Neovim with `:qa` key sequence
- Now start up Neovim again with:

```bash
    nvim # will install the Treesitter binaries
```

- Now you should have a working Neovim development setup

## Install azure CLI

see [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)

## Install Golang

```bash
    GO_VERSION=1.17.6
    wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar xzf go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local/
    echo export PATH=\$PATH:/usr/local/go/bin >>~/.profile
    rm go1.17.6.linux-amd64.tar.gz
```

## Install kubectl

see [https://kubernetes.io/docs/tasks/tools/install-kubectl-linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)
for Ubuntu `hirsute` release (21.10) see [https://issueexplorer.com/issue/Azure/azure-cli/20058](https://issueexplorer.com/issue/Azure/azure-cli/20058)

## Install Powershell

see [https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2](https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2)

## Install kubelogin

see [here](https://github.com/int128/kubelogin/releases)

## Install tmux

```bash
    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp [PATH-TO-THIS-REPO-CHECKOUT]/wsl/.tmux.conf ~/
```

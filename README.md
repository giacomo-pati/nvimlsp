# nvimdotfiles

Neovim configuration system

## Installation of Prereqs on WSL/Ubuntu (system level)

- WSL: Install "Ubuntu 20.04 LTS"
- open shell and execute the following commands:

```sh
    sudo sh -c "echo $USER ALL=\(ALL\) NOPASSWD:ALL >>/etc/sudoers.d/$USER" # to allow using 'sudo' without a password
    sudo su -
    vi /etc/update-manager/release-upgrades # change `Prompt=normal`
```

- execute the following commands to upgrade to Ubuntu 21.04:

```sh
    apt install update-manager-core
    apt purge snapd -y # it will otherwise prevent do-release-upgrade
    apt update
    apt upgrade -y
    do-release-upgrade # if it fails, skip it, follow instaructions: for Mail config chose "No configuration"
    apt install snapd -y # reinstall to make MS happy
```

- if you want to stay on 20.04 do the following:

```sh
    apt update
    apt upgrade -y
```

- exit and repoen shell
- execute the following commands to install Neovim universe:

```sh
    sudo su -
    add-apt-repository ppa:neovim-ppa/stable # or unstable as you like
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E sh -
    apt update
    apt install -y neovim python3-dev python3-pip nodejs ruby-full cpanminus \
        luarocks sqlite3 locate ripgrep fd-find daemonize dbus-user-session \
        fontconfig dos2unix shellcheck cargo black flake8 default-jdk \
        apt-transport-https default-jdk lynx zsh silversearcher-ag fzf
    pip3 install --upgrade pynvim msgpack
    npm install -g npm@latest neovim@latest @fsouza/prettierd@latest eslint_d@latest
    gem install neovim
    snap install glow
```

- exit all shells completely!

## Installation of Prereqs on WSL/Ubuntu (user level)

- open shell and execute the following commands:

```sh
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    mkdir -p ~/.fonts
    unzip JetBrainsMono.zip -d ~/.fonts
    rm JetBrainsMono.zip
    fc-cache -fv
    # cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5 -Mlocal::lib)
    cargo install stylua
    curl -sS https://webinstall.dev/zoxide | sh
    pip install neovim-remote
    go install github.com/jesseduffield/lazygit@latest
```

- Make sure the following environment variables get set next time you login by executing:

```sh
    #echo export PERL5LIB=/home/giacomo/perl5/lib/perl5 >>~/.profile
    #echo export PERL_LOCAL_LIB_ROOT=/home/giacomo/perl5 >>~/.profile
    #echo export PERL_MB_OPT=\"--install_base /home/giacomo/perl5\" >>~/.profile
    #echo export PERL_MM_OPT=INSTALL_BASE=/home/giacomo/perl5 >>~/.profile
    echo export PATH=\${PATH}:\${HOME}/.cargo/bin >>~/.profile
```

- exit all shells completely!

## Installation of this Neovim configuration

- open shell and execute the following commands:

```sh
    mkdir -p ~/.config
    rm -rf ~/.local/share/nvim/ ~/.config/nvim/ ~/.cache/nvim/
    cp -a [PATH-TO-THIS-REPO-CHECKOUT]/nvim ~/.config/
    nvim # this will install all plugins
```

- Quit Neovim with `:qa` key sequence
- Now start up Neovim again with:

```sh
    nvim # will install the Treesitter binaries
```

- Now you should have a working Neovim development setup

## Install azure CLI

see [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)

## Install Golang

```sh
    GO_VERSION=1.17.6
    wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar xzf go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local/
    echo export PATH=\${PATH}:/usr/local/go/bin >>~/.profile
    rm go1.17.6.linux-amd64.tar.gz
```

## Install kubectl & kubelogin

```sh
az aks install-cli
```

see [https://kubernetes.io/docs/tasks/tools/install-kubectl-linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)
for Ubuntu `hirsute` release (21.10) see [https://issueexplorer.com/issue/Azure/azure-cli/20058](https://issueexplorer.com/issue/Azure/azure-cli/20058)

## Install Powershell

see [https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2](https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2)

## Install tmux

```sh
    sudo apt install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp [PATH-TO-THIS-REPO-CHECKOUT]/wsl/.tmux.conf ~/
```

## Install Pulumi

```sh
    curl -fsSL https://get.pulumi.com | sh -s -- --version $PULUMI_VERSION
    echo export PATH=\${PATH}:\${HOME}/.pulumi/bin >>~/.profile
```

## Install Maven

```sh
    MAVEN_VERSION=3.8.4
    (
      cd /tmp
      wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
      sudo tar xf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt
      sudo ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
      rm /tmp/apache-maven-${MAVEN_VERSION}.tar.gz
    )
    echo export JAVA_HOME=/usr/lib/jvm/default-java >>~/.profile
    echo export M2_HOME=/opt/maven >>~/.profile
    echo export MAVEN_HOME=/opt/maven >>~/.profile
    echo export PATH=\${PATH}:\${M2_HOME}/bin >>~/.profile
```

## Install Gradle

```sh
    sudo add-apt-repository ppa:cwchien/gradle
    sudo apt update
    sudo apt -y install gradle
```

## Install Dive (Docker Image Inspection Tool)

```sh
    DIVE_VERSION=$(curl -s "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo dive.deb "https://github.com/wagoodman/dive/releases/latest/download/dive_${DIVE_VERSION}_linux_amd64.deb"
    sudo apt install -y ./dive.deb
    rm -rf dive.deb
```

## Shell Installation/Configuration

### For ZSHELL installation

```sh
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    cp -a [PATH-TO-THIS-REPO-CHECKOUT]/shell/zshcustom/* ~/.oh-my-zsh/custom/
    cp [PATH-TO-THIS-REPO-CHECKOUT]/shell/.*profile ~/
    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/' ~/.zshrc
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sed -i 's/^plugins=.*$/plugins=(ag docker kubectl z zsh-autosuggestions history-substring-search zsh-syntax-highlighting)/' ~/.zshrc
```

Put the following on top of your ~/.zshrc file:

```sh
# Download Znap, if it's not there yet.
[[ -f ~/projects/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/projects/zsh-snap

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
```

## Installation and configuration via Ansible playbook

```sh
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
sudo ansible-pull -U https://github.com/giacomo-pati/nvimlsp.git

```

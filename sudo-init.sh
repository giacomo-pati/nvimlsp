#!/bin/sh
sh -c "echo $USER ALL=\(ALL\) NOPASSWD:ALL >>/etc/sudoers.d/$USER" # to allow using 'sudo' without a password
vi /etc/update-manager/release-upgrades # change `Prompt=normal`
apt install update-manager-core
apt purge snapd -y # it will otherwise prevent do-release-upgrade
apt update
apt upgrade -y
do-release-upgrade # if it fails, skip it, follow instaructions: for Mail config chose "No configuration"
apt install snapd -y # reinstall to make MS happy
add-apt-repository ppa:neovim-ppa/stable # or unstable as you like
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E sh -
apt update
apt install -y neovim python3-dev python3-pip nodejs ruby-full cpanminus \
    luarocks sqlite3 locate ripgrep fd-find daemonize dbus-user-session \
    fontconfig dos2unix shellcheck cargo black flake8 default-jdk \
    apt-transport-https default-jdk lynx zsh
pip3 install --upgrade pynvim msgpack
npm install -g npm@latest neovim@latest @fsouza/prettierd@latest eslint_d@latest
gem install neovim
snap install glow

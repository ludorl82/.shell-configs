#!/bin/bash

cd ~/

# Install packages
sudo add-apt-repository ppa:neovim-ppa/stable 
sudo apt-get update
sudo apt install -y tmux zsh ruby-full python3-pip iftop mtr telnet squid rsync bind9-dnsutils open-vm-tools libnss-ldap libpam-ldap ldap-utils jq neovim exuberant-ctags
sudo echo "vmhgfs-fuse    /mnt/hgfs    fuse    defaults,allow_other    0    0" >> /etc/fstab

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && rm -f install.sh

# Set timezone
sudo timedatectl set-timezone America/Montreal

sudo gem install tmuxinator
pip3 install --user virtualenvwrapper

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf aws

# Install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Installing kubetail
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/johanhaleby/kubetail.git kubetail
cp ~/.oh-my-zsh/custom/plugins/kubetail/kubetail ~/.local/bin

# Installing openssh-server
sudo apt install -y openssh-server

# Install node and npm https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04
curl -sL https://deb.nodesource.com/setup_17.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
sudo apt install build-essential
sudo npm i -g bash-language-server
sudo npm install -g yarn
yarn config set "strict-ssl" false -g
yarn install

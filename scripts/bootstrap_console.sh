#!/bin/bash

cd ~/

# Install packages
sudo add-apt-repository ppa:neovim-ppa/stable 
sudo apt-get update
sudo apt install -y zsh ruby-full python3-pip iftop mtr telnet squid rsync bind9-dnsutils open-vm-tools libnss-ldap libpam-ldap ldap-utils jq neovim exuberant-ctags

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && rm -f install.sh

# Set timezone
sudo timedatectl set-timezone America/Montreal

# Install tmuxinator
read -p "Install terraform (y|n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  mkvirtualenv terraform
  wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
  unzip terraform_0.12.24_linux_amd64.zip
  mv terraform ~/.virtualenvs/terraform/bin
  rm -f terraform_0.12.24_linux_amd64.zip
  deactivate
  mkvirtualenv terragrunt
  wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.23.14/terragrunt_linux_amd64
  mv terragrunt_linux_amd64 ~/.virtualenvs/terragrunt/bin/terragrunt
  deactivate
fi

# Install tmuxinator
sudo gem install tmuxinator
pip3 install --user virtualenvwrapper

# Install AWS CLI
read -p "Install AWS CLI (y|n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	rm -f awscliv2.zip
	rm -rf aws
fi

# Install kubectl
read -p "Install kubectl (y|n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

	# Installing kubetail
	cd ~/.oh-my-zsh/custom/plugins/
	git clone https://github.com/johanhaleby/kubetail.git kubetail
	cp ~/.oh-my-zsh/custom/plugins/kubetail/kubetail ~/.local/bin
fi

# Installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

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

# Install docker
sudo apt -y install curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io

# Add yourself to docker group
sudo usermod -aG docker $(whoami)

# Install tmux
sudo apt update && sudo apt install -y git automake build-essential pkg-config libevent-dev libncurses5-dev byacc bison
rm -fr /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout 3.0
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux

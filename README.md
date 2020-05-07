# shell-configs

# Use Hack Nerd Font Mono 12pt
# https://www.nerdfonts.com/font-downloads

List of installations to be done for new profile:

* Install tmuxinator
```
sudo apt install ruby-full tmux
gem install --user-install tmuxinator -v 1.1.5
sudo gem install tmuxinator
```

* Install virtualenvs: (http://sametmax.com/les-environnement-virtuels-python-virtualenv-et-virtualenvwrapper/)
```
sudo apt install python python3 python-pip python3-pip
pip3 install --user virtualenvwrapper
```

* Install Terraform and Terragrunt in virtualenv
```
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
```

* Install AWS CLI
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf aws
```

* Install kubectl https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/#installation-%C3%A0-l-aide-des-gestionnaires-des-paquets-natifs
```
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

* To set correct language in Windows 10 with WSL: https://superuser.com/questions/1096411/windows-10-loses-settings-of-keyboard-layout-shortcuts-hotkeys-for-input-langua
Set language to French Canadian with 2 keyboard layouts:
- Canadian Multilingual Standard
- US English
Set keyboard shortcuts for each of the languages, disable shortcuts to switch between languages.
Set Canadian French as default input method and authorize switching language with application.
Follow the mentionned link above to copy language settings to the whole computer.

* To install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
~/.fzf/uninstall
cd ~/.fzf && git pull && ./install

* To install vim mode
git clone https://github.com/softmoth/zsh-vim-mode.git ~/.zsh-vim-mode

* To install kubetail
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/johanhaleby/kubetail.git kubetail
cp ~/.oh-my-zsh/custom/plugins/kubetail ~/.local/bin

* To install onedrive
https://github.com/abraunegg/onedrive/blob/master/docs/INSTALL.md

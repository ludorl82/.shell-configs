#!/bin/bash

PLUGINS_DIR="$HOME/.config/nvim/pack/bundle/start"
[ ! -d $PLUGINS_DIR/awesome-vim-colorschemes ] && mkdir -p $PLUGINS_DIR

# Upgrade vim plugins
cd $PLUGINS_DIR
[ ! -d $PLUGINS_DIR/awesome-vim-colorschemes ] && git clone https://github.com/rafi/awesome-vim-colorschemes.git
[ ! -d $PLUGINS_DIR/coc.nvim ] && git clone https://github.com/neoclide/coc.nvim.git
[ ! -d $PLUGINS_DIR/fzf ] && git clone https://github.com/junegunn/fzf.git
[ ! -d $PLUGINS_DIR/fzf.vim ] && git clone https://github.com/junegunn/fzf.vim.git
[ ! -d $PLUGINS_DIR/nerdtree ] && git clone https://github.com/preservim/nerdtree.git
[ ! -d $PLUGINS_DIR/vim-airline ] && git clone https://github.com/vim-airline/vim-airline.git
[ ! -d $PLUGINS_DIR/vim-devicons ] && git clone https://github.com/ryanoasis/vim-devicons.git
[ ! -d $PLUGINS_DIR/vim-fugitive ] && git clone https://github.com/tpope/vim-fugitive.git
[ ! -d $PLUGINS_DIR/vim-gitgutter ] && git clone https://github.com/airblade/vim-gitgutter.git
[ ! -d $PLUGINS_DIR/vim-matchit ] && git clone https://github.com/adelarsq/vim-matchit.git
[ ! -d $PLUGINS_DIR/vim-tmux-navigator ] && git clone https://github.com/christoomey/vim-tmux-navigator.git
find $PLUGINS_DIR -mindepth 1 -maxdepth 1 -type d -exec git --git-dir={}/.git --work-tree={} pull \;

# Upgrade tmux themepack
cd $HOME
[ ! -d $HOME/.tmux-themepack ] && git clone https://github.com/jimeh/tmux-themepack.git $HOME/.tmux-themepack
git --git-dir=$HOME/.tmux-themepack/.git --work-tree=$HOME/.tmux-themepack pull

# Upgrade tmux yank
[ ! -d $HOME/.tmux-yank ] && git clone https://github.com/tmux-plugins/tmux-yank.git $HOME/.tmux-yank
git --git-dir=$HOME/.tmux-yank/.git --work-tree=$HOME/.tmux-yank pull

# Upgrade zsh-vi-mode
[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode ] && git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
git --git-dir=$HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode/.git --work-tree=$HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode pull

# Upgrade zsh kube context
[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-kubectl-prompt ] && git clone https://github.com/superbrothers/zsh-kubectl-prompt.git ~/.oh-my-zsh/custom/plugins/zsh-kubectl-prompt
git --git-dir=$HOME/.oh-my-zsh/custom/plugins/zsh-kubectl-prompt/.git --work-tree=$HOME/.oh-my-zsh/custom/plugins/zsh-kubectl-prompt pull

# Upgrade spaceduck
[ ! -d $HOME/.tmux-spaceduck-terminal ] && git clone https://github.com/pineapplegiant/spaceduck-terminal.git ~/.tmux-spaceduck-terminal
git --git-dir=$HOME/.tmux-spaceduck-terminal/.git --work-tree=$HOME/.tmux-spaceduck-terminal pull

cd ~/.config/nvim/pack/bundle/start/coc.nvim/
yarn install
yarn build

# Ensure SSH configs are done
SSHD_CONFIG="/etc/ssh/sshd_config"
SSH_CONFIG1="X11Forwarding yes"
SSH_CONFIG2="AcceptEnv LANG LC_* ENV CLIENT"
if [[ "$(grep "^$SSH_CONFIG1" $SSHD_CONFIG | wc -l)" == "0" ]]; then
  echo "${SSH_CONFIG1}" | sudo tee -a $SSHD_CONFIG
  echo Just applied $SSH_CONFIG1
else
  echo $SSH_CONFIG1 already configured
fi
if [[ "$(grep "${SSH_CONFIG2:20}" $SSHD_CONFIG | wc -l)" = "0" ]]; then
  echo "${SSH_CONFIG2}" | sudo tee -a $SSHD_CONFIG
  echo Just applied $SSH_CONFIG2
else
  echo $SSH_CONFIG2 already configured
fi

# Sync console configs
CONFIGS_DIR="$HOME/.shell-configs/configs"
SCRIPTS_DIR="$HOME/.shell-configs/scripts"

# Vim
[ ! -d ~/.config/nvim ] && mkdir ~/.config/nvim
rsync -avh "${CONFIGS_DIR}/.config/nvim/" ~/.config/nvim

# ZSH
\cp $CONFIGS_DIR/.zshrc* ~/
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
                      && rm -f install.sh
[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-vi-mode ] && git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
if [ ! -d ~/.oh-my-zsh/custom/plugins/kubetail ]; then
  cd ~/.oh-my-zsh/custom/plugins/
  git clone https://github.com/johanhaleby/kubetail.git kubetail
  [ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
  cp ~/.oh-my-zsh/custom/plugins/kubetail/kubetail ~/.local/bin
fi

# FZF
if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  ~/.fzf/uninstall
  cd ~/.fzf && git pull && ./install
fi

# tmux
\cp $CONFIGS_DIR/.tmux.conf ~/
\cp $CONFIGS_DIR/.tmux.console.conf ~/
\cp $CONFIGS_DIR/.tmux.ide.conf ~/
\cp $CONFIGS_DIR/.tmux.keys.conf ~/
\cp $CONFIGS_DIR/.tmux.Linux.conf ~/
\cp $CONFIGS_DIR/.gitmux.conf ~/
rsync -avh "${CONFIGS_DIR}/.config/tmuxinator/" $HOME/.config/tmuxinator --delete

# SSH
[ ! -d ~/.ssh/ ] && mkdir -p ~/.ssh/ && ssh-keygen
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/authorized_keys ]; then
  ssh-import-id-gh ludorl82
fi

# Git
\cp $CONFIGS_DIR/.gitconfig ~/

# Bash for zsh in WSL
\cp $CONFIGS_DIR/.bashrc ~/
\cp $CONFIGS_DIR/.inputrc ~/

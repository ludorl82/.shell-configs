#!/bin/bash

CONFIGS_DIR="$HOME/.shell-configs/configs"
SCRIPTS_DIR="$HOME/.shell-configs/scripts"

cd ~/.shell-configs

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

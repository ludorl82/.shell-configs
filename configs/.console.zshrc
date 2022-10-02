export ZSH="$HOME/.zsh"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$ZSH/.fzf/bin

# Set histfile
export HISTFILE="$HOME/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_space
setopt appendhistory

# Enabling advanced completion (git, etc)
autoload -Uz compinit && compinit

# Set tmux vars
[[ "$TMUX" != "" ]] && [ -z ${TMUX_DISPLAY+x} ] && TMUX_DISPLAY="$(tmux display -p '#S')"
[[ "$TMUX" != "" ]] && [ -z ${WINDOW+x} ] && WINDOW="$(tmux display-message -p '#W')"

# Create aliases
source $ZSH/.zshrc-aliases

# Set theme and plugins
[ -d $ZSH/plugins/zsh-vi-mode ] && source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh && KEYTIMEOUT=1
if [[ "$TMUX" == "" ]]; then
  autoload -U colors && colors
  PROMPT="%{$fg[green]%}$> %{$reset_color%}"
  RPROMPT=" -- %{$fg[blue]%}%d%{$reset_color%}"
else
  source $ZSH/themes/agnoster-zsh-theme/agnoster.zsh-theme
  source $ZSH/plugins/zsh-kubectl-prompt/zsh-kubectl-prompt.plugin.zsh
  [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
fi

# Allow key bindings after zsh-vi-mode
function zvm_after_init() {
  # FZF
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

  # Enable history search
  bindkey "^[[1~" beginning-of-line
  bindkey "^[[4~" end-of-line
  bindkey "^P" history-beginning-search-backward
  bindkey "^N" history-beginning-search-forward
  stty -ixon

  # Restore C-D
  bindkey "^D" delete-char
}

# Source external scripts
[ "$(uname)" != "" ] && source "$ZSH/.zshrc-`uname`"
source "$ZSH/.zshrc-${USER}"

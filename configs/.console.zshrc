export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export EDITOR=nvim

# Set histfile
HISTFILE="$HOME/.histfile"
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_space
setopt appendhistory

# Set tmux vars
[[ "$TMUX" != "" ]] && [ -z ${TMUX_DISPLAY+x} ] && TMUX_DISPLAY="$(tmux display -p '#S')"
[[ "$TMUX" != "" ]] && [ -z ${WINDOW+x} ] && WINDOW="$(tmux display-message -p '#W')"

# Set theme and plugins
if [[ "$TMUX" == "" ]]; then
  autoload -U colors && colors
  PROMPT="%{$fg[green]%}$> %{$reset_color%}"
  RPROMPT=" -- %{$fg[blue]%}%d%{$reset_color%}"
  plugins=(zsh-vi-mode)
elif [[ "$TMUX_DISPLAY" =~ (console) ]]; then
  ZSH_THEME="crunch"
  plugins=(git gitfast kubectl kubetail zsh-vi-mode)
elif [[ "$TMUX_DISPLAY" =~ (k8s) ]]; then
  ZSH_THEME="crunch"
  plugins=(git gitfast kubectl kubetail zsh-vi-mode zsh-kubectl-prompt)
else
  ZSH_THEME="agnoster"
  plugins=(git gitfast zsh-vi-mode)
fi

source $ZSH/oh-my-zsh.sh

# Make vi mode escape sequence faster
KEYTIMEOUT=1

# Create aliases
source $HOME/.zshrc-aliases

# Allow key bindings after zsh-vi-mode
function zvm_after_init() {
  # FZF
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
[ "$(uname)" != "" ] && source "$HOME/.zshrc-`uname`"
source "$HOME/.zshrc-${USER}"

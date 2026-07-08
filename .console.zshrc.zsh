# Set git password in memory
git config --global credential.credentialStore cache
git config --global credential.helper 'cache --timeout=604800'

# Enabling advanced completion (git, etc)
autoload -Uz compinit && compinit

# Fix windows terminal paste
[[ "$CLIENT" == "terminal" ]] && unset zle_bracketed_paste

# AWS CLI autocompletion
autoload -U +X bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Set tmux vars if TMUX is not empty
if [[ -n "$TMUX" ]]; then
  [ -z ${TMUX_DISPLAY} ] && TMUX_DISPLAY="$(tmux display -p '#S')"
  [ -z ${WINDOW} ] && WINDOW="$(tmux display-message -p '#W')"
  [[ -v CWD ]] && cd "${CWD}"
fi

# Create aliases
source $HOME/.aliases.sh

# Set theme and plugins
if [[ -z "$TMUX" ]]; then
  autoload -U colors && colors
  PROMPT="%{$fg[green]%}$> %{$reset_color%}"
  RPROMPT=" -- %{$fg[blue]%}%d%{$reset_color%}"
else
  # Source plugins
  source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

  # Source theme
  setopt promptsubst
  source $ZSH/themes/powerlevel10k/powerlevel10k.zsh-theme
  [[ -f $ZSH/p10k.zsh ]] && source $ZSH/p10k.zsh

  # FZF
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
fi

# Create key bindings
source $ZSH/bindings.zsh

# Source external scripts
[[ -f "$ZSH/`uname`.zsh" ]] && source "$ZSH/`uname`.zsh"
[[ -f "$ZSH/${USER}.zsh" ]] && source "$ZSH/${USER}.zsh"

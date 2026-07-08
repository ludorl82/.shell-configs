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

# Source plugins
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# FZF
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# Set theme (Nord, matches tmux and nvim)
eval "$(starship init zsh)"

# Create key bindings
source $ZSH/bindings.zsh

# Source external scripts
[[ -f "$ZSH/`uname`.zsh" ]] && source "$ZSH/`uname`.zsh"
[[ -f "$ZSH/${USER}.zsh" ]] && source "$ZSH/${USER}.zsh"

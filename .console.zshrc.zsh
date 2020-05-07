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
  source $ZSH/themes/agnoster-zsh-theme/agnoster.zsh-theme

  # Custom (Random emoji)
  prompt_context() {
    sed -i 's/CROSS="\\u2718"/CROSS="\\u00d7"/g' $HOME/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
    sed -i 's/GEAR="\\u2699"/GEAR="\\u00f6"/g' $HOME/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
    emojis=(
      "\\u00AE" "\\u00B6" "\\u00BF" "\\u00C6" "\\u00DE" "\\u00DF" 
      "\\u00B5" "\\u00A9" "\\u00A7" "\\u00A5" "\\u00A4" "\\u00A3" 
      "\\u00A2" "\\u00DF" "\\u00E6" "\\u00B1" "\\u00A1" "\\u00A6" 
      "\\u00AA" "\\u00AC"
    )
    RAND_EMOJI_1=$(( $RANDOM % ${#emojis[@]} + 1))
    prompt_segment black default "%n ${emojis[$RAND_EMOJI_1]} %T "
  }

  # FZF
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
fi

# Create key bindings
source $ZSH/bindings.zsh

# Source external scripts
[[ -f "$ZSH/`uname`.zsh" ]] && source "$ZSH/`uname`.zsh"
[[ -f "$ZSH/${USER}.zsh" ]] && source "$ZSH/${USER}.zsh"

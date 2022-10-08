export ZSH="$HOME/.zsh"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:$PATH
export PATH=/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.fzf/bin:$PATH

# Set histfile
export HISTFILE="$ZSH/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_space
setopt appendhistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Set locale
export LC_ALL=C.UTF-8
export LANG=fr_CA.UTF-8
export LC_CTYPE=fr_CA.UTF-8
export LANGUAGE=fr_CA.UTF-8
export LC_TIME=fr_CA.UTF-8
export USER="$(id -n -u)"

# Enabling advanced completion (git, etc)
autoload -Uz compinit && compinit

# Set tmux vars
[[ "$TMUX" != "" ]] && [ -z ${TMUX_DISPLAY+x} ] && TMUX_DISPLAY="$(tmux display -p '#S')"
[[ "$TMUX" != "" ]] && [ -z ${WINDOW+x} ] && WINDOW="$(tmux display-message -p '#W')"

# Set current working directory
[[ "$TMUX" != "" ]] && [[ -v CWD ]] && cd "${CWD}"

# Create aliases
source $ZSH/aliases.zsh

# Set theme and plugins
#[ -d $ZSH/plugins/zsh-vi-mode ] && source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh && KEYTIMEOUT=1
if [[ "$TMUX" == "" ]]; then
  autoload -U colors && colors
  PROMPT="%{$fg[green]%}$> %{$reset_color%}"
  RPROMPT=" -- %{$fg[blue]%}%d%{$reset_color%}"
else
  # Source plugins
  [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
  source $ZSH/plugins/zsh-kubectl-prompt/zsh-kubectl-prompt.plugin.zsh
  source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  #source $ZSH/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

  # Source theme
  source $ZSH/themes/agnoster-zsh-theme/agnoster.zsh-theme
  prompt_context() {
    # Custom (Random emoji)
    emojis=("🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🇹🇭" "🚦" "🌙")
    RAND_EMOJI_1=$(( $RANDOM % ${#emojis[@]} + 1))
    prompt_segment black default "%n ${emojis[$RAND_EMOJI_1]} %T "
  }

  # FZF
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

  # Create key bindings
  source $ZSH/bindings.zsh
fi

# Source external scripts
[ "$(uname)" != "" ] && source "$ZSH/`uname`.zsh"
source "$ZSH/${USER}.zsh"

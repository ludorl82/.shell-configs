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
source $ZSH/.zshrc-aliases

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
  source $ZSH/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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

  # Enable history search
  #bindkey "^[[1~" beginning-of-line
  #bindkey "^[[4~" end-of-line
  #bindkey "^P" up-line-or-search
  #bindkey "^N" down-line-or-search
  bindkey "^P" history-beginning-search-backward
  bindkey "^N" history-beginning-search-forward
  bindkey "^F" forward-char
  bindkey "^B" backward-char
  bindkey "^E" end-of-line
  bindkey "^A" beginning-of-line
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  stty -ixon

  # Fix word delete with C-W
  # So it stops at slash and dash
  my-backward-delete-word() {
      local WORDCHARS=${WORDCHARS/\//}
      local WORDCHARS=${WORDCHARS/-/}
      local WORDCHARS=${WORDCHARS/./}
      zle backward-delete-word
  }
  zle -N my-backward-delete-word
  bindkey '^W' my-backward-delete-word

  # Restore C-D
  bindkey "^D" delete-char

  # Set C-f to add one char of auto suggest at the time
	ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
		end-of-line
		vi-forward-char
		vi-end-of-line
		vi-add-eol
	)

  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    forward-char
		forward-word
		emacs-forward-word
		vi-forward-word
		vi-forward-word-end
		vi-forward-blank-word
		vi-forward-blank-word-end
		vi-find-next-char
		vi-find-next-char-skip
	)
fi

# Allow key bindings after zsh-vi-mode
#function zvm_after_init() {
#  # FZF
#  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
#
#  # Enable history search
#  #bindkey "^[[1~" beginning-of-line
#  #bindkey "^[[4~" end-of-line
#  #bindkey "^P" up-line-or-search
#  #bindkey "^N" down-line-or-search
#  bindkey "^P" history-beginning-search-backward
#  bindkey "^N" history-beginning-search-forward
#  stty -ixon
#
#  # Fix word delete with C-W
#  # So it stops at slash and dash
#  my-backward-delete-word() {
#      local WORDCHARS=${WORDCHARS/\//}
#      local WORDCHARS=${WORDCHARS/-/}
#      local WORDCHARS=${WORDCHARS/./}
#      zle backward-delete-word
#  }
#  zle -N my-backward-delete-word
#  bindkey '^W' my-backward-delete-word
#
#  # Restore C-D
#  bindkey "^D" delete-char
#
#  # Set C-f to add one char of auto suggest at the time
#	ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
#		end-of-line
#		vi-forward-char
#		vi-end-of-line
#		vi-add-eol
#	)
#
#  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
#    forward-char
#		forward-word
#		emacs-forward-word
#		vi-forward-word
#		vi-forward-word-end
#		vi-forward-blank-word
#		vi-forward-blank-word-end
#		vi-find-next-char
#		vi-find-next-char-skip
#	)
#}

# Source external scripts
#[ "$(uname)" != "" ] && source "$ZSH/.zshrc-`uname`"
#source "$ZSH/.zshrc-${USER}"

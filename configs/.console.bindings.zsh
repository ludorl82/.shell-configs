bindkey -v "^P" history-beginning-search-backward # Enable history search
bindkey -v "^N" history-beginning-search-forward # Enable history search
bindkey "^F" forward-char
bindkey "^B" backward-char
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line
#bindkey "^[[1;5C" forward-word # Forward word C-right arrow
#bindkey "^[[1;5D" backward-word # Backward word C-left arrow
#bindkey "^[f" forward-word
#bindkey "^[b" backward-word
bindkey "^D" delete-char # Restore C-D
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

# open command in editor
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ 	]*[0-9]+\**[ 	]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

export FZF_DEFAULT_OPTS='--color=bw'

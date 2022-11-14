# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ludorl82/.zsh/plugins/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ludorl82/.zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ludorl82/.zsh/plugins/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ludorl82/.zsh/plugins/fzf/shell/key-bindings.bash"

export FZF_DEFAULT_OPTS='--color=bw'

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ludorl82/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ludorl82/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ludorl82/.zsh/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ludorl82/.zsh/plugins/fzf/shell/key-bindings.zsh"

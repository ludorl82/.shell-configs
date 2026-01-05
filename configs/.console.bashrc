# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set bash history size to unlimited and update on every command
HISTSIZE=100000
HISTFILESIZE=100000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r;"

# Set prompt with red for root
if [ "`whoami`" = "root" ]; then usercolor='\[\033[1;31m\]'; else usercolor='\[\033[38;5;231m\]'; fi
export PS1="\[\033[38;5;7m\][\t]\[$(tput sgr0)\] \[$(tput sgr0)\]${usercolor}\u\[$(tput sgr0)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\] \\$ \[$(tput sgr0)\]"

alias console="export ENV=console && export CLIENT=linux && ssh -p2222 -o SendEnv=ENV -o SendEnv=CLIENT -R 8022:localhost:8022 localhost"

source ~/.fzf.bash

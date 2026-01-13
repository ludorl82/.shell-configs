# Launch zsh if exists and not asked to skip
# To open bash use: NOZSH=1 bash
if [ -f /bin/zsh ] && [ -z ${NOZSH+x} ] && [ "`whoami`" != "root" ]; then exec zsh; return; fi

# Set prompt
export PS1="\[]0;\u@\h: \w\]${debian_chroot:+($debian_chroot)}\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\]\$ "

# Source fzf if exists
if [ -f ~/.fzf.bash ]; then . ~/.fzf.bash; fi

# Source aliases if exists
if [ -f ~/.aliases.sh ]; then . ~/.aliases.sh; fi

# Source kubectl completion if exists
#source <(kubectl completion bash)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set bash history size to unlimited and update on every command
HISTSIZE=
HISTFILESIZE=
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r;"

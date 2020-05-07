alias ll='ls -alF --color'
alias grep='grep --color=auto'
alias mux='~/.shell-scripts/scripts/tmuxinator_wrapper.sh'
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

alias gco='git checkout'
alias gst='git status'

alias pbcopy="~/.shell-scripts/scripts/pbcopy.sh"

[[ -f ~/.aliases-${USER}.sh ]] && source ~/.aliases-${USER}.sh

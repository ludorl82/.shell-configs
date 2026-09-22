alias ll='ls -alF --color'
alias grep='grep --color=auto'
alias mux='~/.shell-scripts/scripts/tmuxinator_wrapper.sh'
# macOS seulement : le script refuse ailleurs. L'alias est ici quand meme,
# parce que ce fichier est le seul endroit d'ou les scripts sont atteignables
# -- ~/.shell-scripts/scripts n'est pas sur le PATH.
alias switch-mac='~/.shell-scripts/scripts/switch-mac.sh'
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

alias gco='git checkout'
alias gst='git status'

alias pbcopy="~/.shell-scripts/scripts/pbcopy.sh"

[[ -f ~/.aliases-${USER}.sh ]] && source ~/.aliases-${USER}.sh

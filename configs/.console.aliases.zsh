alias mux='~/.shell-scripts/scripts/tmuxinator_wrapper.sh'
alias vim='nvim'
alias vi='nvim'
alias kubectld='docker exec -e ENV=$ENV -e TMUX_DISPLAY=$TMUX_DISPLAY -e WINDOW=$WINDOW -e TMUX=$TMUX -e CLIENT=$CLIENT -ti $(docker ps | grep kubectl | awk '\''{print $1}'\'') /usr/bin/zsh'
alias awsclid='docker exec -e ENV=$ENV -e TMUX_DISPLAY=$TMUX_DISPLAY -e WINDOW=$WINDOW -e TMUX=$TMUX -e CLIENT=$CLIENT -ti $(docker ps | grep awscli | awk '\''{print $1}'\'') /usr/bin/zsh'
alias terraform_0.12.29d='docker exec -e ENV=$ENV -e TMUX_DISPLAY=$TMUX_DISPLAY -e WINDOW=$WINDOW -e TMUX=$TMUX -e CLIENT=$CLIENT -ti $(docker ps | grep terraform_0.12.29 | awk '\''{print $1}'\'') /usr/bin/zsh'
alias terraform_1.1.9d='docker exec -e ENV=$ENV -e TMUX_DISPLAY=$TMUX_DISPLAY -e WINDOW=$WINDOW -e TMUX=$TMUX -e CLIENT=$CLIENT -ti $(docker ps | grep terraform_1.1.9 | awk '\''{print $1}'\'') /usr/bin/zsh'

alias gco='git checkout'
alias gst='git status'

if [[ "${TMUX_DISPLAY}" =~ (console|k8s) ]]; then
  command -v kubectl &> /dev/null && alias kadmin="kubectl --kubeconfig ~/.kube/config-admin.yaml"
  command -v kubectl &> /dev/null && alias kadminc="export KUBECONFIG=$HOME/.kube/config-admin.yaml"
  command -v kubectl &> /dev/null && alias kd='kubectl drain --ignore-daemonsets --delete-local-data'
  alias pbcopy="~/.shell-scripts/scripts/pbcopy.sh"
fi

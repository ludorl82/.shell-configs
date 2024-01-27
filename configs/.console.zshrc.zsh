export ZSH="$HOME/.zsh"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:$PATH
export PATH=/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.fzf/bin:$PATH
export PATH=$PATH:/usr/local/bin/go/bin/:/home/nvim/.local/bin:/home/nvim/.local/bin/bin:/home/nvim/go/bin:/home/nvim/.cargo/bin
export GOPATH=$HOME/share/go
export PATH=$PATH:$GOPATH/bin

# Set histfile
export HISTFILE="$ZSH/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
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
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

# Set git password in memory
git config --global credential.credentialStore cache
git config --global credential.helper 'cache --timeout=604800'

# Enabling advanced completion (git, etc)
autoload -Uz compinit && compinit

# Set tmux vars
[[ "$TMUX" != "" ]] && [ -z ${TMUX_DISPLAY} ] && TMUX_DISPLAY="$(tmux display -p '#S')"
[[ "$TMUX" != "" ]] && [ -z ${WINDOW} ] && WINDOW="$(tmux display-message -p '#W')"

# Set current working directory
[[ "$TMUX" != "" ]] && [[ -v CWD ]] && cd "${CWD}"

# Create aliases
source $ZSH/aliases.zsh

# Set theme and plugins
if [[ "$TMUX" == "" ]]; then
  autoload -U colors && colors
  PROMPT="%{$fg[green]%}$> %{$reset_color%}"
  RPROMPT=" -- %{$fg[blue]%}%d%{$reset_color%}"
  export $(cat $HOME/.config/.env/openai_api_key.env | xargs)
  export OPENAI_KEY=$OPENAI_API_KEY
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
    sed -i 's/CROSS="\\u2718"/CROSS="\\u00d7"/g' $HOME/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
    sed -i 's/GEAR="\\u2699"/GEAR="\\u00f6"/g' $HOME/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
    emojis=( "\\u00AE" "\\u00B6" "\\u00BF" "\\u00C6" "\\u00DE" "\\u00DF" "\\u00B5" "\\u00A9" "\\u00A7" "\\u00A5" "\\u00A4" "\\u00A3" "\\u00A2" "\\u00DF" "\\u00E6" "\\u00B1" "\\u00A1" "\\u00A6" "\\u00AA" "\\u00AC")
    RAND_EMOJI_1=$(( $RANDOM % ${#emojis[@]} + 1))
    prompt_segment black default "%n ${emojis[$RAND_EMOJI_1]} %T "
  }

  # FZF
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

  # Create key bindings
  source $ZSH/bindings.zsh
fi

# Source external scripts
source "$ZSH/`uname`.zsh"
source "$ZSH/${USER}.zsh"

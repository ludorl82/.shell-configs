# Set environment variables
export TERM="xterm-256color"
export EDITOR=nvim
export USER="$(id -n -u)"
export GOPATH=/usr/local/go
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

# Set PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin
export PATH=$PATH:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.fzf/bin
export PATH=$PATH:/usr/local/bin/go/bin/:/home/nvim/.local/bin:/home/nvim/.local/bin/bin:/home/nvim/go/bin:/home/nvim/.cargo/bin
export PATH=$PATH:$GOPATH/bin

# Set history settings
export HISTFILE="$HOME/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

# Set locale
export LC_ALL=C.UTF-8
export LANG=fr_CA.UTF-8
export LC_CTYPE=fr_CA.UTF-8
export LANGUAGE=fr_CA.UTF-8
export LC_TIME=fr_CA.UTF-8
export TZ=America/Toronto

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

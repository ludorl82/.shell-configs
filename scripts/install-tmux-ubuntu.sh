#!/usr/bin/env bash

sudo apt update && sudo apt install -y git automake build-essential pkg-config libevent-dev libncurses5-dev byacc bison
rm -fr /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout 3.0
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux

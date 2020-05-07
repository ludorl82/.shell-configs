#!/bin/bash

if [[ ! -z "$DISPLAY" ]]; then
  xclip -o -sel c
elif [[ "$CLIENT" = "termux" ]]; then
  echo -n "$(ssh -p8022 u0_a311@localhost 'termux-clipboard-get')"
else
  echo "No clipboard sync method" && exit 0
fi

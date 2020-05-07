#!/bin/bash

string="$(</dev/stdin)"
[[ -z "$string" ]] && string="$(tmux save-buffer -)"
echo -n "$string" | tmux load-buffer -b t -

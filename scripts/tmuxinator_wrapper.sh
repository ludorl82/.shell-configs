#!/bin/bash

display="$1"

if [ "$display" == "" ]; then echo "Display $display cannot be empty" && exit 1; fi

[[ "$ENV" == "console" ]] && [[ "$display" == "console" ]] && tmuxinator $display && exit 0;
[[ "$ENV" == "console" ]] && [[ "$display" == "k8s" ]] && tmuxinator $display && exit 0;
[[ "$ENV" == "console" ]] && echo "Env: $ENV cannot open display: $display" && exit 1

[[ "$ENV" == "IDE" ]] && [[ "$display" == "ide" ]] && tmuxinator $display && exit 0;
[[ "$ENV" == "IDE" ]] && echo "Env: $ENV cannot open display: $display" && exit 1

echo "Invalid env: $ENV" && exit 1

#!/bin/bash

# Set environment
export ENV=$1
export DISPLAY=localhost:0.0
ssh -Y -o SendEnv=ENV ludorl82@ssh

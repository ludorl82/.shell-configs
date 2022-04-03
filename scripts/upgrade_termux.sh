#!/data/data/com.termux/files/usr/bin/bash

pkg install git openssh wget vim

git config --global user.email "ludo+github@rl82.com"
git config --global user.name "Ludovic Lamarre"
git config --global credential.helper store

# Ensure Termux configs are done
TRMX_CONFIG="$HOME/.termux/termux.properties"
TRX_CONFIG1="extra-keys = [[]]"
if [[ "$(grep "^$TRX_CONFIG1" $TRMX_CONFIG | wc -l)" == "0" ]]; then
  echo "${TRX_CONFIG1}" >> $TRMX_CONFIG
  echo Just applied $TRX_CONFIG1
else
  echo $TRX_CONFIG1 already configured
fi


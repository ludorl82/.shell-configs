#!/data/data/com.termux/files/usr/bin/bash

pkg install git openssh wget vim

git config --global user.email "ludo+github@rl82.com"
git config --global user.name "Ludovic Lamarre"
git config --global credential.helper store

# Ensure Termux configs are done
TRMX_CONFIG="$HOME/.termux/termux.properties"
TRX_CONFIG1="extra-keys = [[]]"
TRX_CONFIG2="fullscreen = true"
if [[ "$(grep "^${TRX_CONFIG1::-7}" $TRMX_CONFIG | wc -l)" == "0" ]]; then
  echo "${TRX_CONFIG1}" >> $TRMX_CONFIG
  echo Just applied $TRX_CONFIG1
else
  echo $TRX_CONFIG1 already configured
fi
if [[ "$(grep "^${TRX_CONFIG2::-7}" $TRMX_CONFIG | wc -l)" == "0" ]]; then
  echo "${TRX_CONFIG2}" >> $TRMX_CONFIG
  echo Just applied $TRX_CONFIG2
else
  echo $TRX_CONFIG2 already configured
fi

# Generate openssh keys if not already present
if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
  ssh-keygen
fi

# Install fonts
if [[ ! -f "$HOME/.termux/font.ttf" ]]; then
  mkdir $HOME/.termux/fonts
  wget -O $HOME/.termux/fonts/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
  unzip $HOME/.termux/fonts/Hack.zip -d $HOME/.termux/fonts
  cp $HOME/.termux/fonts/Hack\ Regular\ Nerd\ Font\ Complete\ Mono.ttf $HOME/.termux/font.ttf
  rm -rf ~/.termux/fonts
fi

# Copy bashrc
echo Copying .bashrc
\cp $HOME/.shell-configs/configs/.termux.bashrc $HOME/.bashrc

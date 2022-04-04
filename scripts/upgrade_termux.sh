#!/data/data/com.termux/files/usr/bin/bash

pkg install git openssh wget vim

git config --global user.email "ludo+github@rl82.com"
git config --global user.name "Ludovic Lamarre"
git config --global credential.helper store

# Declare function to update config parameters
validateParam() {
  param="$1"
  confg="$2"

  if [[ "$(grep "^${param::-7}" $confg | wc -l)" == "0" ]]; then
    echo "$param" >> $confg
    echo Just applied $param
  else
    echo $param already configured
  fi
}

# Ensure Termux configs are done
TRMX_CONFIG="$HOME/.termux/termux.properties"
TRX_CONFIGS=("extra-keys = [[]]" "fullscreen = true")
for config in ${!TRX_CONFIGS[@]}; do
  validateParam "${TRX_CONFIGS[$config]}" $TRMX_CONFIG
done

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

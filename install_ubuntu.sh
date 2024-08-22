#!/bin/bash

if [[ $1 == "help" ]] ; then
  echo "Options: fonts"
  exit 0
fi

sudo apt-get update
sudo apt-get install curl fish git kitty neovim i3 i3blocks rofi dunst firefox feh diodon


if [[ $1 == "zsh" ]] ; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ $1 == "fonts" ]] ; then
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
fi

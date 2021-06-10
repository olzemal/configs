#!/bin/bash

# This script will install my desktop Linux configuration
# Note: This will only work on Arch based Distributions



# Install requirements
sudo pacman -S exa zsh starship


# Set zsh as default shell

# Get configs for the selected Window manager
case $wm in $(read -p "Select your Window manager (i3/xmonad/ALL)")
    i3)
	    ;;
    xmonad)
	    ;;
    *)
	    ;;

mkdir -p $HOME/.xmonad $HOME/.config

cp .zshrc .vimrc $HOME/

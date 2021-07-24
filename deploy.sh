#!/bin/sh

if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
fi
if [ ! -d "$HOME/.config/alacritty" ]; then
    mkdir -p "$HOME/.config/alacritty"
fi

cp alacritty.yml	"$HOME/.config/alacritty/"
cp .aliases		"$HOME/"
cp .bashrc		"$HOME/"
cp .spectrwm.conf	"$HOME/"
cp starship.toml	"$HOME/.config/"
cp .vimrc		"$HOME/"
cp .zshrc		"$HOME/"


#!/bin/sh

[ ! -d "$HOME/.config"           ] && mkdir -p "$HOME/.config"
[ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
[ ! -d "$HOME/.config/ranger"    ] && mkdir -p "$HOME/.config/ranger"

echo "Installing CLI Tool Configs"
ln -s .aliases          "$HOME/.aliases"
ln -s starship.toml	"$HOME/.config/starship.toml"
ln -s .zshrc		"$HOME/.zshrc"
ln -s .vimrc		"$HOME/.vimrc"
ln -s .bashrc		"$HOME/.bashrc"
ln -s rc.conf           "$HOME/.config/ranger/rc.conf"

[ "$1" = "cli" ] && exit 0

echo "Installing Desktop Configs"
ln -s alacritty.yml	"$HOME/.config/alacritty/alacritty.yml"
ln -s .spectrwm.conf	"$HOME/.spectrwm.conf"


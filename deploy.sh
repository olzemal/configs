#!/bin/sh

[ -f "$HOME/.bashrc"             ] && mv "$HOME/.bashrc" "$HOME/.bashrc.old"
[ -f "$HOME/.vmrc"               ] && mv "$HOME/.vimrc" "$HOME/.vimrc.old"

[ ! -d "$HOME/.config"           ] && mkdir -p "$HOME/.config"
[ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
[ ! -d "$HOME/.config/ranger"    ] && mkdir -p "$HOME/.config/ranger"

echo "Installing CLI Tool Configs"
ln -s "$PWD/.aliases"           "$HOME/.aliases"
ln -s "$PWD/starship.toml"	"$HOME/.config/starship.toml"
ln -s "$PWD/.zshrc"		"$HOME/.zshrc"
ln -s "$PWD/.vimrc"		"$HOME/.vimrc"
ln -s "$PWD/.bashrc"		"$HOME/.bashrc"
ln -s "$PWD/rc.conf"            "$HOME/.config/ranger/rc.conf"

[ "$1" = "cli" ] && exit 0

echo "Installing Desktop Configs"
ln -s "$PWD/alacritty.yml"      "$HOME/.config/alacritty/alacritty.yml"
ln -s "$PWD/.spectrwm.conf"	"$HOME/.spectrwm.conf"


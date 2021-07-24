#!/bin/sh

[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.config/alacritty ] && mkdir -p ~/.config/alacritty

echo "Installing CLI Tool Configs"
cp .aliases		~/.aliases
cp starship.toml	~/.config/starship.toml
cp .zshrc		~/.zshrc
cp .vimrc		~/.vimrc
cp .bashrc		~/.bashrc

[ $1 == "cli" ] && exit 0

echo "Installing Desktop Configs"
cp alacritty.yml	~/.config/alacritty/alacritty.yml
cp .spectrwm.conf	~/.spectrwm.conf


#!/bin/sh
for option in "$@"
do
    case $option in
        alacritty)
            [ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
            ln -s "$PWD/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
            ;;
        aliases)
            ln -s "$PWD/shell/.aliases" "$HOME/.aliases"
            ;;
        bash)
            ln -s "$PWD/shell/.bashrc"	"$HOME/.bashrc"
            ;;
        ranger)
            [ ! -d "$HOME/.config/ranger" ] && mkdir -p "$HOME/.config/ranger"
            ln -s "$PWD/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
            ;;
        spectrwm)
            ln -s "$PWD/spectrwm/.spectrwm.conf" "$HOME/.spectrwm.conf"
            ;;
        starship)
            ln -s "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
            ;;
	vim)
            ln -s "$PWD/vim/.vimrc" "$HOME/.vimrc"
	    ;;
        zsh)
            ln -s "$PWD/shell/.zshrc" "$HOME/.zshrc"
            ;;
        *)
            printf "no config file found for \"$option\"\n"
    esac
done


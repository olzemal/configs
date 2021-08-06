#!/bin/sh
# shellcheck disable=SC1117

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
            [ ! -d "$HOME/.scripts" ] && git clone https://gitlab.com/olzemal/scripts.git "$HOME/.scripts" && chmod -R +x "$HOME/.scripts/"
            ln -s "$PWD/shell/.bashrc" "$HOME/.bashrc"
            ln -s "$PWD/shell/.bash_profile" "$HOME/.bash_profile"
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
            [ ! -d "$HOME/.scripts" ] && git clone https://gitlab.com/olzemal/scripts.git "$HOME/.scripts" && chmod -R +x "$HOME/.scripts/"
            ln -s "$PWD/shell/.zshrc" "$HOME/.zshrc"
            ;;
        *)
            printf "no config file found for \"%s\"\n" "$option"
            ;;
    esac
done


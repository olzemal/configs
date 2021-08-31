#!/bin/sh

link() {
    [ -e "$2" ] && printf 'found existing file %s\n' "$2" && rm -i "$2"
    ln -s "$1" "$2" 2>/dev/null
}

help() {
    printf 'Choose one or more options from the following list\nto add as an argument to the script:\n'
    grep '[a-z])' "$0" | sed 's/)//' | xargs printf ' - %s\n'
}

[ $# -eq 0 ] && help

for option in "$@"
do
    case $option in
        alacritty)
            [ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
            link "$PWD/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
            ;;
        aliases)
            [ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
            link "$PWD/shell/aliases" "$HOME/.config/aliases"
            ;;
        bash)
            [ ! -d "$HOME/.scripts" ] && \
                git clone https://gitlab.com/olzemal/scripts.git "$HOME/.scripts" && \
                chmod -R +x "$HOME/.scripts/"
            link "$PWD/shell/bashrc" "$HOME/.bashrc"
            link "$PWD/shell/bash_profile" "$HOME/.bash_profile"
            ;;
        ranger)
            [ ! -d "$HOME/.config/ranger" ] && mkdir -p "$HOME/.config/ranger"
            link "$PWD/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
            ;;
        spectrwm)
            link "$PWD/spectrwm/spectrwm.conf" "$HOME/.spectrwm.conf"
            ;;
        starship)
            link "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
            ;;
        tmux)
            [ ! -d "$HOME/.config/tmux" ] && mkdir -p "$HOME/.config/tmux"
            link "$PWD/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
            ;;
        vim)
            link "$PWD/vim/vimrc" "$HOME/.vimrc"
	        ;;
        zsh)
            [ ! -d "$HOME/.scripts" ] && git clone https://gitlab.com/olzemal/scripts.git "$HOME/.scripts" && chmod -R +x "$HOME/.scripts/"
            link "$PWD/shell/zshrc" "$HOME/.zshrc"
            ;;
    	cli)
            eval "$0 bash aliases tmux vim"
            ;; 
        *)
            printf '\033[0;31mno config file found for "%s"\033[0m\n' "$option"
            help
            exit 1
            ;;
    esac
    printf '\033[0;32mDeployed configs for %s\033[0m\n' "$option"
done


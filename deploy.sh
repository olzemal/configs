#!/bin/bash

link() {
    [ -e "$2" ] && printf 'found existing file %s\n' "$2" && rm -i "$2"
    ln -s "$1" "$2" 2>/dev/null
}

help() {
    printf 'Choose one or more options from the following list\nto add as an argument to the script:\n'
    grep '[a-z])' "$0" | sed 's/)//' | xargs printf ' - %s\n'
}

versionge() {
    # Run as `versionge "$(mycommand -v)" "<required version>"`
    # Return 0 if version requirement is satisfied
    # Return 1 if version requirement is not satisfied

    current="${1//[!0-9\.]/}"
    desired="${2//[!0-9\.]/}"
    
    IFS="." read -r -a c <<< "${current}"
    IFS="." read -r -a d <<< "${desired}"

    lc="${#c[*]}"
    ld="${#d[*]}"

    [ "$lc" -gt "$ld" ] && {
        for i in $(seq "$ld" $((lc-1)))
        do
            d[$i]=0
        done
    }

    [ "$ld" -gt "$lc" ] && {
        for i in $(seq "$lc" $((ld-1)))
        do
            c[$i]=0
        done
    }

    for i in $(seq 0 $((lc-1)))
    do
        [ ${d[$i]} -gt ${c[$i]} ] && return 1
        [ ${d[$i]} -lt ${c[$i]} ] && return 0
    done
    return 0
}

[ $# -eq 0 ] && help

for option in "$@"
do
    case $option in
        alacritty)
            [ ! -d "$HOME/.config/alacritty" ] && \
                mkdir -p "$HOME/.config/alacritty"
            link "$PWD/alacritty/alacritty.yml" \
                "$HOME/.config/alacritty/alacritty.yml"
            ;;

        aliases)
            [ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
            link "$PWD/shell/aliases" "$HOME/.config/aliases"
            ;;

        bash)
            # Clone scripts repo
            [ ! -d "$HOME/.scripts" ] && \
                git clone https://gitlab.com/olzemal/scripts.git \
                    "$HOME/.scripts"
            
            # Deploy bashrc
            link "$PWD/shell/bashrc" "$HOME/.bashrc"

            # Deploy bash_profile
            link "$PWD/shell/profile" "$HOME/.profile"
            ;;

        ranger)
            # Deploy rc.conf
            [ ! -d "$HOME/.config/ranger" ] && mkdir -p "$HOME/.config/ranger"
            link "$PWD/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

            # Install ueberzug
            [ -z "$(command -v ueberzug)" ] && sudo pip3 install ueberzug
            ;;

        tmux)
            # Deploy tmux.conf
            if versionge "$(tmux -V)" "3.1"; then
                [ ! -d "$HOME/.config/tmux" ] && mkdir -p "$HOME/.config/tmux"
                link "$PWD/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
            else
                link "$PWD/tmux/tmux.conf" "$HOME/.tmux.conf"
            fi
            ;;

        vim)
            # Install Plug
            [ ! -e "$HOME/.vim/autoload/plug.vim" ] && \
                curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            
            # Deploy vimrc
            if versionge \
                "$(vim --version | head -1 | grep -oP '\d\.\d')" \
                "7.3"
            then
                [ ! -d "$HOME/.vim" ] && mkdir -p "$HOME/.vim"
                link "$PWD/vim/vimrc" "$HOME/.vim/vimrc"
            else
                link "$PWD/vim/vimrc" "$HOME/.vimrc"
            fi

            # Run PlugInstall
            vim +PlugInstall +qall
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


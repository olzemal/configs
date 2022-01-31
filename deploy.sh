#!/bin/sh
# shellcheck disable=SC2086

first() {
    [ -n "$1" ] && printf '%s' "$1" || printf '%s' "$1"
}

link() {
    [ -e "$2" ] && printf 'found existing file %s\n' "$2" && rm -i "$2"
    ln -s "$1" "$2" 2>/dev/null
}

help() {
    printf 'Choose one or more options from the following list\nto add as an argument to the script:\n'
    grep -P '^\s+[a-z]+\)' "$0" | sed 's/)//' | xargs printf ' - %s\n'
}

versionge() {
    # Run as `versionge "$(mycommand -v)" "<required version>"`
    # Return 0 if version requirement is satisfied
    # Return 1 if version requirement is not satisfied
    current="$(printf '%s' "$1" | sed -e 's/\./\ /g' -e 's/[^0-9\ ]//g')"
	desired="$(printf '%s' "$2" | sed -e 's/\./\ /g' -e 's/[^0-9\ ]//g')"

	while [ -n "$current" ]; do
	    # Return 1 if not satisfied
		[ "$(first $current)" -lt "$(first $desired)" ] && return 1
		# Return 0 if satisfied
		[ "$(first $current)" -gt "$(first $desired)" ] && return 0
		# Therefore continue if eqal
		# Delete First element (and leading space) of $current and $desired
		current=${current#$(first $current)}
		current=${current#${current%%[![:space:]]*}}
        desired=${desired#$(first $desired)}
        desired=${desired#${desired%%[![:space:]]*}}
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

        lynx)
            [ ! -d "$HOME/.config/lynx" ] && mkdir -p "$HOME/.config/lynx"
            link "$PWD/lynx/lynx.lss" "$HOME/.config/lynx/lynx.lss"
            link "$PWD/lynx/lynx.cfg" "$HOME/.config/lynx/lynx.cfg"
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

        minivim)
            # Deploy vimrc
            if versionge \
                "$(vim --version | head -1 | grep -oP '\d\.\d')" \
                "7.3"
            then
                [ ! -d "$HOME/.vim" ] && mkdir -p "$HOME/.vim"
                link "$PWD/vim/vimrc-minimal" "$HOME/.vim/vimrc"
            else
                link "$PWD/vim/vimrc-minimal" "$HOME/.vimrc"
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

            # Install go binaries if go is installed
            [ -n "$(command -v go)" ] && [ ! -f "$GOBIN/golint" ] \
                vim +GoInstallBinaries
            ;;

        zsh)
            [ ! -d "$HOME/.scripts" ] && \
                git clone https://gitlab.com/olzemal/scripts.git \
                    "$HOME/.scripts" && chmod -R +x "$HOME/.scripts/"
            link "$PWD/shell/zshrc" "$HOME/.zshrc"
            ;;

    	cli)
            eval "$0 bash aliases tmux vim lynx"
            ;;

        *)
            printf '\033[0;31mno config file found for "%s"\033[0m\n' "$option"
            help
            exit 1
            ;;
    esac
    printf '\033[0;32mDeployed configs for %s\033[0m\n' "$option"
done


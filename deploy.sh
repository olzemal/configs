#!/bin/sh
# shellcheck disable=SC2086

# Check if deploy is in current dir
if [ $0 != "./deploy.sh" ]; then
  printf 'Not executing from config repo dir, this will mess up symlinks... exiting\n'
  exit 1
fi

link() {
  [ ! -d "$(dirname "$2")" ] && mkdir -p "$(dirname "$2")"
  [ -e "$2" ] && printf 'found existing file %s\n' "$2" && rm -i "$2"
  ln -s "$1" "$2" 2>/dev/null
}

help() {
  printf 'Choose one or more options from the following list\nto add as an argument to the script:\n'
  grep -P '^\s+[a-z\-]+\)' "$0" | sed 's/)//' | xargs printf ' - %s\n'
}

versionge() {
  # Run as `versionge "$(mycommand -v)" "<required version>"`
  # Return 0 if version requirement is satisfied
  [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1 )" = "$2" ] && return 0
  # Return 1 if version requirement is not satisfied
  return 1
}

isinstalled() {
  # return 1 if $1 is not installed
  # return 0 if $1 is installed
  if [ -z "$(which $1)" ]; then
    printf 'Looks like %s is not installed... exiting\n' "$1" >&2
    return 1
  fi
  return 0
}

[ $# -eq 0 ] && help

for option in "$@"; do
  case $option in
    alacritty)
      link "$PWD/alacritty/alacritty.yaml" "$HOME/.config/alacritty/alacritty.yml"
      ;;

    aliases)
      link "$PWD/shell/aliases" "$HOME/.config/aliases"
      ;;

    bash)
      if ! isinstalled "bash"; then exit 5; fi

      # Deploy scripts
      eval "$0 scripts"

      # Deploy bashrc
      link "$PWD/shell/bashrc" "$HOME/.bashrc"

      # Deploy bash_profile
      link "$PWD/shell/bash_profile" "$HOME/.bash_profile"
      link "$PWD/shell/profile" "$HOME/.profile"
      ;;

    code)
      link "$PWD/code/settings.json" "$HOME/.config/Code/User/settings.json"
      ;;

    git)
      if ! isinstalled "git"; then exit 5; fi

      if [ -z "$EMAIL" ]; then
        printf 'Please enter your email adress: '
        read -r email
        echo "export EMAIL=$email" >> ~/.local/localrc
        printf 'Remember to restart bash\n'
      fi
      link "$PWD/git/gitconfig" "$HOME/.gitconfig"
      ;;

    gnome)
      dconf load / < ./gnome/dconf-dump.txt
      ;;

    kitty)
      if ! isinstalled "kitty"; then exit 5; fi
      link "$PWD/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
      ;;

    nvim)
      if ! isinstalled "nvim"; then exit 5; fi
      if ! isinstalled "rg"; then exit 5; fi
      if ! isinstalled "npm"; then exit 5; fi

      # Install Plug
      [ ! -d "$HOME/.local/share/nvim/site/autoload" ] && mkdir -p "$HOME/.local/share/nvim/site/autoload"
      curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      link "$PWD/vim/vimrc" "$HOME/.config/nvim/init.vim"

      # Run PlugInstall
      nvim +PlugInstall +qall

      # Install Mason Packages
      nvim -c "MasonInstall \
        bash-language-server \
        gopls \
        docker-compose-language-service \
        dockerfile-language-server \
        helm-ls \
        jq \
        jq-lsp \
        json-lsp \
        yq \
        awk-language-server\
        marksman \
        nginx-language-server \
        python-lsp-server \
        biome \
        sqlls \
        terraform-ls \
        vim-language-server \
        taplo"

      # Install go binaries if go is installed
      isinstalled go && [ ! -f "$GOBIN/golint" ] && \
        nvim +GoInstallBinaries
      ;;

    scripts)
      link "$PWD/scripts" "$HOME/.scripts"
      ;;

    tmux)
      if ! isinstalled "tmux"; then exit 5; fi
      link "$PWD/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
      ;;

    vim)
      if ! isinstalled "vim"; then exit 5; fi

      # Install Plug
      [ ! -e "$HOME/.vim/autoload/plug.vim" ] && \
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      # Deploy vimrc
      if versionge \
        "$(vim --version | head -1 | grep -oP '\d\.\d')" "7.3"
      then
        link "$PWD/vim/vimrc" "$HOME/.vim/vimrc"
      else
        link "$PWD/vim/vimrc" "$HOME/.vimrc"
      fi

      # Run PlugInstall
      vim +PlugInstall +qall

      # Install go binaries if go is installed
      [ -n "$(command -v go)" ] && [ ! -f "$GOBIN/golint" ] && \
        vim +GoInstallBinaries
      ;;

    zsh)
      if ! isinstalled "zsh"; then exit 5; fi

      # Deploy scripts
      eval "$0 scripts"

      # Deploy zshrc
      link "$PWD/shell/zshrc" "$HOME/.zshrc"
      ;;

    cli)
      eval "$0 bash aliases scripts git vim nvim"
      ;;

    *)
      printf '\033[0;31mno config file found for "%s"\033[0m\n' "$option"
      help
      exit 1
      ;;
  esac
  printf '\033[0;32mDeployed configs for %s\033[0m\n' "$option"
done

#!/bin/sh
# shellcheck disable=SC1091 # source files
# shellcheck disable=SC2059 # variables in printf format string

set -e

DEPLOY='./deploy.sh'
TOOLS='./tools.txt'
ASDF_VERSION='v0.14.0'
PYTHON_VERSION='3.12'

info()    { printf "\033[0;34mINFO:\033[0m $1" "$2"; }
success() { printf "\033[0;32mSUCC:\033[0m $1" "$2"; }
warn()    { printf "\033[1;33mWARN:\033[0m $1" "$2"; }
fatal()   { printf "\033[0;31mFATA:\033[0m $1" "$2"; exit 1; }


# Check if deploy is in current dir
[ "$(dirname "$0")" = "." ] || fatal 'Not executing from configs repo dir, this will probably mess up symlinks\n' ''

link() {
  [ ! -d "$(dirname "$2")" ] && mkdir -p "$(dirname "$2")"
  [ -e "$2" ] && warn 'found existing file %s\n' "$2" && rm -i "$2"
  ln -s "$1" "$2" 2>/dev/null
}

help() {
  info 'Choose one or more options from the following list\nto add as an argument to the script:\n' ''
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
  if [ -z "$(which "$1")" ]; then
    info 'Looks like %s is not installed\n' "$1"
    return 1
  fi
  return 0
}

asdf_install() {
  export ASDF_DIR="$HOME/.asdf"
  [ -f "$ASDF_DIR/asdf.sh" ] || "$DEPLOY" asdf
  . "$HOME/.asdf/asdf.sh"

  if isinstalled "$1"; then
    warn '%s is already installed. Install anyways? (y/N) ' "$1"
    read -r confirm
    case "$confirm" in y|Y) ;; *) return 0 ;; esac
  fi

  info 'Trying to install %s with asdf...\n' "$1"
  asdf plugin-add "$1"
  latest=$(asdf latest "$1")
  asdf install "$1" "$latest"
  asdf global "$1" "$latest"
}

[ $# -eq 0 ] && help

for option in "$@"; do
  case $option in
    asdf)
      git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch "$ASDF_VERSION"
      ;;

    aliases)
      link "$PWD/shell/aliases" "$HOME/.config/aliases"
      ;;

    bash)
      isinstalled bash || asdf_install bash
      "$DEPLOY" scripts
      "$DEPLOY" aliases

      # Deploy bashrc
      link "$PWD/shell/bashrc" "$HOME/.bashrc"

      # Deploy bash_profile
      link "$PWD/shell/bash_profile" "$HOME/.bash_profile"
      link "$PWD/shell/profile" "$HOME/.profile"
      ;;

    vscode)
      link "$PWD/code/settings.json" "$HOME/.config/Code/User/settings.json"
      ;;

    git)
      isinstalled git || asdf_install git
      link "$PWD/git/gitconfig" "$HOME/.gitconfig"
      ;;

    gnome)
      dconf load / < ./gnome/dconf-dump.txt
      ;;

    image)
      docker build -t workspace:latest .
      ;;

    kitty)
      if ! isinstalled "kitty"; then exit 5; fi
      link "$PWD/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
      ;;

    nvim)
      isinstalled "nvim"    || asdf_install neovim
      isinstalled "go"      || asdf_install golang
      isinstalled "rg"      || asdf_install ripgrep
      isinstalled "npm"     || asdf_install nodejs
      isinstalled "python3" || "$DEPLOY" pyenv

      # Install python module for nvim
      . ./shell/profile
      python3 -m pip install neovim

      # Install npm module for nvim
      npm install -g neovim

      # Install Plug
      [ ! -d "$HOME/.local/share/nvim/site/autoload" ] && mkdir -p "$HOME/.local/share/nvim/site/autoload"
      curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      link "$PWD/vim/init.lua" "$HOME/.config/nvim/init.lua"

      # Run PlugInstall
      nvim --headless -c PlugInstall +qall

      # Install Mason Packages
      nvim --headless -c "MasonInstall \
        bash-language-server \
        gopls \
        docker-compose-language-service \
        dockerfile-language-server \
        helm-ls \
        jq \
        jq-lsp \
        json-lsp \
        yq \
        marksman \
        python-lsp-server \
        biome \
        sqlls \
        terraform-ls \
        vim-language-server \
        taplo" +qall

      # Install go binaries if go is installed
      isinstalled go && [ ! -f "$(go env GOBIN)/golint" ] && \
        nvim --headless -c GoInstallBinaries +qall
      ;;

    pyenv)
      git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
      "$HOME/.pyenv/bin/pyenv" install "$PYTHON_VERSION"
      "$HOME/.pyenv/bin/pyenv" global "$PYTHON_VERSION"
      ;;

    scripts)
      link "$PWD/scripts" "$HOME/.scripts"
      ;;

    tmux)
      isinstalled tmux || asdf_install tmux
      link "$PWD/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
      ;;

    tools)
      tools=""
      while read -r tool; do tools="$tools $tool"; done < "$TOOLS"
      for tool in $tools; do
        asdf_install "$tool"
      done
      ;;

    vim)
      isinstalled vim || asdf_install vim
      # Deploy vimrc
      if versionge "$(vim --version | head -1 | grep -oP '\d\.\d')" "7.3"
      then
        link "$PWD/vim/vimrc" "$HOME/.vim/vimrc"
      else
        link "$PWD/vim/vimrc" "$HOME/.vimrc"
      fi
      ;;

    zsh)
      isinstalled zsh || asdf_install zsh
      "$DEPLOY" scripts
      link "$PWD/shell/zshrc" "$HOME/.zshrc"
      ;;

    cli)
      "$DEPLOY" bash git vim nvim
      ;;

    *)
      warn 'no config file found for "%s"\n' "$option"
      help
      exit 1
      ;;
  esac
  success 'deployed target %s\n' "$option"
done

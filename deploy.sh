#!/bin/sh

if [ -z "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

home_manager_dir="$HOME/.config/home-manager"

[ ! -d "$home_manager_dir" ] && mkdir -p "$home_manager_dir"
ln -s "$PWD/home.nix" "$home_manager_dir/home.nix"

home-manager switch

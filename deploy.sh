#!/bin/sh

if [ -z "$(command -v home-manager)" ]; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

home-manager switch --flake .#alex

{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/Users/alex";

  imports = [
    ./common

    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/nvim
    ./features/terminals/kitty.nix
    ./features/tmux
    ./features/kubernetes/client.nix
  ];
}

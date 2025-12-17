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
    ./features/tmux
    ./features/kubernetes/client.nix
  ];
}

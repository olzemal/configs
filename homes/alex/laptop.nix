{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  imports = [
    ./common

    ./features/gui/common.nix
    ./features/gui/gnome

    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/vscode
    ./features/editors/nvim
    ./features/terminals/kitty.nix

    ./features/browsers/firefox.nix
    ./features/kubernetes/client.nix

    ./features/gaming
    ./features/fpv
  ];
}

{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  imports = [
    ./common

    ./features/gui/common.nix
    ./features/gui/gnome
    ./features/gui/gnome/dock-alex.nix

    ./features/ai/opencode.nix
    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/vscode
    ./features/editors/nvim
    ./features/tmux
    ./features/terminals/kitty.nix
    ./features/terminals/ghostty.nix

    ./features/browsers/firefox.nix
    ./features/kubernetes/client.nix

    ./features/gaming
    ./features/fpv
  ];
}

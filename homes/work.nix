{ config, pkgs, ... }:

{
  home.username = "work";
  home.homeDirectory = "/home/work";

  imports = [
    ./common

    ./features/gui/common.nix
    ./features/gui/gnome
    ./features/gui/gnome/dock-work.nix

    ./features/ai/opencode.nix
    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/vscode
    ./features/editors/nvim
    ./features/tmux
    ./features/terminals/kitty.nix

    ./features/browsers/firefox.nix
    ./features/kubernetes/client.nix
  ];
}

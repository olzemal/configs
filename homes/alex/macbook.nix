{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/Users/alex";

  home.packages = with pkgs.unstable; [
    qtpass
  ];

  imports = [
    ./common

    ./features/ai/opencode.nix
    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/nvim
    ./features/terminals/kitty.nix
    ./features/tmux
    ./features/kubernetes/client.nix
  ];
}

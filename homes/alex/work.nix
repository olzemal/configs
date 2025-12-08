{ config, pkgs, ... }:

{
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

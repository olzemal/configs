{ config, pkgs, ... }:

{
  imports = [
    ./common

    ./features/git
    ./features/bash
    ./features/scripts
    ./features/editors/nvim
    ./features/kubernetes/client.nix
  ];
}

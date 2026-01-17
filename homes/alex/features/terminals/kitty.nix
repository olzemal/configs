{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    extraConfig = pkgs.lib.readFile ./kitty.conf;
  };
}

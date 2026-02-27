{ pkgs, ... }:

{
  programs.kitty = {
    extraConfig = pkgs.lib.readFile ./kitty.conf;
  };
}

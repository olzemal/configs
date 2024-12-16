{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    steam
    vcv-rack
  ];
}

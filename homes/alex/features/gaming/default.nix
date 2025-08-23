{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    lutris
    vcv-rack
    wine64
    winetricks
  ];
}

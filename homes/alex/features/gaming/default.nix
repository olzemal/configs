{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    lutris
    steam
    vcv-rack
    wine64
    winetricks
  ];
}

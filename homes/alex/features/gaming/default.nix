{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    lutris
    moonlight-qt
    vcv-rack
    wine64
    winetricks
  ];
}

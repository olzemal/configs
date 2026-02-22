{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    moonlight-qt
    vcv-rack
    wine64
    winetricks
  ];
}

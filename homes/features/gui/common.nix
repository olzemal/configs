{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    gimp
    inkscape
    obsidian
    qtpass
    signal-desktop
    slack
  ];
}

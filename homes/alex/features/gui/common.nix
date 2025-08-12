{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    discord
    gimp
    inkscape
    obsidian
    qtpass
    signal-desktop
    slack
    spotify
  ];
}

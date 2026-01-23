{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    element-desktop
    discord
    gimp
    inkscape
    obsidian
    qtpass
    signal-desktop
    slack
  ];
}

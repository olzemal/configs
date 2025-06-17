{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    gimp
    inkscape
    obsidian
    qtpass
  ];
}

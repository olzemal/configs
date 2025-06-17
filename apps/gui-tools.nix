{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    inkscape
    obsidian
    qtpass
  ];
}

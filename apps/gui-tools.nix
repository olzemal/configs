{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    qtpass
    blender
  ];
}

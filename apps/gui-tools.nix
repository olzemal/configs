{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    obsidian
    qtpass
  ];
}

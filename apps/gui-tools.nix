{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    arduino-ide
    blender
    obsidian
    qtpass
  ];
}

{ pkgs, ... }:

{
  programs.element-desktop = {
    enable = true;
    package = pkgs.unstable.element-desktop;
  };
}

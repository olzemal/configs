{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ nerdfonts ];
    fontDir.enable = true;
  };
}

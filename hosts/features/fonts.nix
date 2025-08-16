{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs.nerd-fonts; [
      hack
      iosevka
      jetbrains-mono
    ];
    fontDir.enable = true;
  };
}

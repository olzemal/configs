{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "Hack" ]; }) ];
    fontDir.enable = true;
  };
}

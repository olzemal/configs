{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      ${pkgs.lib.readFile ./kitty.conf}
      ${pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
      macos_option_as_alt left
      ''}
    '';
  };
}

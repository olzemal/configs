{ lib, config, ... }:

{
  options.features.desktopapps.kitty.enable = lib.mkEnableOption "kitty";

  config = {
    programs.kitty = lib.mkIf config.features.desktopapps.kitty.enable {
      enable = true;
      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}

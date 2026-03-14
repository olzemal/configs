{ lib, config, ... }:

{
  options.features.kitty.enable = lib.mkEnableOption "kitty";

  config = {
    programs.kitty = {
      enable = config.features.kitty.enable;
      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}

{ lib, pkgs, config, ... }:

{
  options.features.ai = {
    opencode = {
      enable = lib.mkEnableOption "opencode";
    };
  };

  config = lib.mkIf config.features.ai.opencode.enable {
    home.packages = with pkgs; [ opencode ];
  };
}

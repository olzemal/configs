{ lib, config, ... }:

{
  options.features = {
    firefox.enable = lib.mkEnableOption "firefox";
    chromium.enable = lib.mkEnableOption "chromium";
  };

  config = {
    programs.firefox.enable = lib.mkIf config.features.firefox.enable true;

    programs.chromium.enable = lib.mkIf config.features.chromium.enable true;
  };
}

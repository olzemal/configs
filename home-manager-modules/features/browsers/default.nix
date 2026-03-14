{ lib, config, ... }:

{
  options.features = {
    firefox.enable = lib.mkEnableOption "firefox";
    chromium.enable = lib.mkEnableOption "chromium";
  };

  config = {
    features.firefox.enable = lib.mkDefault config.features.desktopapps.enable;
    programs.firefox.enable = config.features.firefox.enable;

    programs.chromium.enable = config.features.chromium.enable;
  };
}

{ lib, config, ... }:

{
  options.features = {
    firefox.enable = lib.mkEnableOption "firefox";
    chromium.enable = lib.mkEnableOption "chromium";
  };

  config = {
    programs.firefox = lib.mkIf config.features.firefox.enable {
      enable = true;
      configPath = ".mozilla/firefox";
    };

    programs.chromium.enable = lib.mkIf config.features.chromium.enable true;
  };
}

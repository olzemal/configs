{ lib, config, ... }:

{
  options.features = {
    firefox.enable = lib.mkEnableOption "firefox";
    chromium.enable = lib.mkEnableOption "chromium";
  };

  config = {
    features.firefox.enable = lib.mkDefault true;
    programs.firefox = lib.mkIf config.features.firefox.enable {
      enable = true;
      profiles."default" = {
        settings = {
          "browser.compactmode.show" = true;
        };
      };
    };

    programs.chromium.enable = config.features.chromium.enable;
  };
}

{ lib, config, ... }:

{
  config = {
    programs.firefox = lib.mkIf config.features.desktopapps.enable {
      enable = true;
      profiles."default" = {
        settings = {
          "browser.compactmode.show" = true;
        };
      };
    };
    programs.chromium.enable = config.features.desktopapps.enable;
  };
}

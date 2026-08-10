{ lib, config, ... }:

{
  options.features.netbird.enable = lib.mkEnableOption "netbird";
  config.services.netbird = lib.mkIf config.features.netbird.enable {
    enable = true;
    ui.enable = false;
  };
}

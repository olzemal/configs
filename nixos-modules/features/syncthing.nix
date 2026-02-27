{ config, lib, ... }:

{
  options.features.syncthing.enable = lib.mkEnableOption "syncthing";

  config = {
    services.syncthing = lib.mkIf config.features.syncthing.enable {
      enable = true;
      openDefaultPorts = true;
    };
  };
}

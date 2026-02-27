{ lib, config, ... }:

{
  options.features.scripts.enable = lib.mkEnableOption "scripts";

  config = {
    features.scripts.enable = lib.mkDefault true;
    home.file = lib.mkIf config.features.scripts.enable {
      ".local/bin" = {
        source = ./.;
        recursive = true;
      };
    };
  };
}

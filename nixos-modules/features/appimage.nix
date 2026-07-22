{ lib, config, ... }:

{
  options.features = {
    appimage.enable = lib.mkEnableOption "appimage";
  };

  config = lib.mkIf config.features.appimage.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}

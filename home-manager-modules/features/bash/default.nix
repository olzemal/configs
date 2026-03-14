{ lib, config, ... }:

{
  options.features.bash.enable = lib.mkEnableOption "bash";

  config = {
    features.bash.enable = lib.mkDefault true;
    home.file = lib.mkIf config.features.bash.enable {
      ".bashrc".source = ./bashrc;
      ".profile".source = ./profile;
      ".config/aliases".source = ./aliases;
    };
  };
}

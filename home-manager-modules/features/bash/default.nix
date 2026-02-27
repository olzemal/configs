{ lib, config, ... }:

{
  config = lib.mkIf config.features.bash.enable {
    home.file = {
      ".bashrc".source = ./bashrc;
      ".profile".source = ./profile;
      ".config/aliases".source = ./aliases;
    };
  };
}

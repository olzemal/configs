{ lib, config, ... }:

{
  options.features.git.enable = lib.mkEnableOption "git";

  config = {
    features.git.enable = lib.mkDefault true;

    home.file.".gitconfig".source = lib.mkIf config.features.git.enable ./gitconfig;
  };
}

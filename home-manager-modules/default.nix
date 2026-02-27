{ config, lib, pkgs, ... }:

let
  types = lib.types;
in
{
  options.username = lib.mkOption {
    type = types.str;
    description = "Name for the home's user";
  };
  options.features = {
    bash.enable = lib.mkEnableOption "bash";
    nvim.enable = lib.mkEnableOption "nvim";
  };

  config = {
    home.username = config.username;
    home.homeDirectory = "/home/${config.username}";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Default packages
    home.packages = with pkgs; [
      age
      devenv
      dig
      direnv
      fzf
      gh
      gnumake
      htop
      jq
      openssl
      pass
      pre-commit
      semver
      shellcheck
      sops
      tree
      wget
      yq-go
    ];

    # Default features
    features = {
      nvim.enable = lib.mkDefault true;
      bash.enable = lib.mkDefault true;
    };

    # Do not manage keyboard layout by home-manager
    home.keyboard = null;

    programs.zoxide.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
  };

  imports = [
    ./features
  ];
}

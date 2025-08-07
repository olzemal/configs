{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc".source = ./bashrc;
    ".profile".source = ./profile;
    ".config/aliases".source = ./aliases;
  };
}

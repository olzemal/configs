{ config, pkgs, ... }:

{
  home.file = {
    ".local/bin" = {
      source = ./.;
      recursive = true;
    };
  };
}

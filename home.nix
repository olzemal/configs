{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
  ];

  imports = [
    ./wm/gnome/gnome.nix
    ./vim/nvim.nix
  ];

  home.file = {
    ".bashrc".source = ./shell/bashrc;
    ".profile".source = ./shell/profile;
    ".config/aliases".source = ./shell/aliases;
    ".gitconfig".source = ./git/gitconfig;

    ".local/bin" = {
      source = ./scripts;
      recursive = true;
    };

    ".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zoxide.enable = true;
}

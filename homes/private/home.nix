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

  imports = [
    ../../apps/wm/gnome/gnome.nix
    ../../apps/k8s-tools.nix
    ../../apps/games.nix
    ../../apps/chat.nix
    ../../apps/kitty/kitty.nix
    ../../apps/music.nix
    ../../apps/vim/nvim.nix
    ../../apps/gui-tools.nix
    ../../apps/cli-tools.nix
  ];

  home.file = {
    ".bashrc".source = ../../apps/shell/bashrc;
    ".profile".source = ../../apps/shell/profile;
    ".config/aliases".source = ../../apps/shell/aliases;
    ".gitconfig".source = ../../apps/git/gitconfig;

    ".local/bin" = {
      source = ../../apps/scripts;
      recursive = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

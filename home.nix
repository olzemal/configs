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

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".bashrc".source = ./shell/bashrc;
    ".profile".source = ./shell/profile;

    ".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      nvim-web-devicons

      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim

      nvim-dap
      nvim-dap-go
      nvim-dap-ui

      nvim-cmp
      cmp-emoji
      cmp-dictionary
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp

      vim-easy-align

      vim-fugitive
      vim-gitgutter

      ale
      vim-go
      markdown-nvim
      vim-DetectSpellLang

      nerdtree
      telescope-nvim
      plenary-nvim
      vim-visual-multi

      ultisnips
      cmp-nvim-ultisnips

    ];
    extraLuaConfig = ''
      -- Warning: This file is managed by home-manager

      ${builtins.readFile ./vim/lua/options.lua}
    '';
  };
}

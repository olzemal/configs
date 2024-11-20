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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = toLua "vim.cmd.colorscheme('gruvbox')";
      }
      nvim-web-devicons

      nvim-lspconfig

      mason-nvim
      mason-lspconfig-nvim

      nvim-dap
      nvim-dap-go
      nvim-dap-ui

      nvim-cmp
      cmp-emoji
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp

      vim-easy-align

      vim-fugitive
      vim-gitgutter

      ale
      vim-go
      vim-DetectSpellLang

      nerdtree
      telescope-nvim
      plenary-nvim
      vim-visual-multi

      ultisnips
      cmp-nvim-ultisnips
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./vim/lua/options.lua}
      ${builtins.readFile ./vim/lua/cmp.lua}
      ${builtins.readFile ./vim/lua/dap.lua}
      ${builtins.readFile ./vim/lua/lsp.lua}
      ${builtins.readFile ./vim/lua/vimgo.lua}
    '';
  };
}

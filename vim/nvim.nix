{ config, pkgs, ... }:

{
  home.file = {
    ".config/nvim/lua/lib.lua".source = ./lua/lib.lua;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

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
      { plugin = gruvbox-nvim; config = toLua "vim.cmd.colorscheme('gruvbox')"; }
      nvim-web-devicons

      { plugin = nvim-lspconfig; config = toLuaFile ./lua/lsp.lua; }
      mason-nvim
      mason-lspconfig-nvim

      { plugin = nvim-dap; config = toLuaFile ./lua/dap.lua; }
      nvim-dap-go
      nvim-dap-ui

      { plugin = nvim-cmp; config = toLuaFile ./lua/cmp.lua; }
      cmp-emoji
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp

      { plugin = vim-easy-align; config = toLuaFile ./lua/easyalign.lua; }

      vim-fugitive
      vim-gitgutter

      { plugin = ale; config = toLuaFile ./lua/ale.lua; }
      { plugin = vim-go; config = toLuaFile ./lua/vimgo.lua; }
      { plugin = vim-DetectSpellLang; config = toLuaFile ./lua/spelllang.lua; }

      { plugin = nerdtree; config = toLuaFile ./lua/nerdtree.lua; }
      { plugin = telescope-nvim; config = toLuaFile ./lua/telescope.lua; }
      plenary-nvim
      vim-visual-multi

      ultisnips
      cmp-nvim-ultisnips
    ];
    extraLuaConfig = builtins.readFile ./lua/options.lua;
  };
}

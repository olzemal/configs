{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    clang
    delve
    go
    gopls
    helm-ls
    hunspell
    lua-language-server
    marksman
    nixd
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    pyright
    ripgrep
    yaml-language-server
  ];

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
    vimPlug = pkgs.vimPlugins;
  in {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;
    vimdiffAlias = true;
    plugins =  [
      { plugin = vimPlug.gruvbox-nvim; config = toLua "vim.cmd.colorscheme('gruvbox')"; }
      vimPlug.nvim-web-devicons

      { plugin = vimPlug.nvim-lspconfig; config = toLuaFile ./lua/lsp.lua; }

      vimPlug.playground
      { plugin = vimPlug.nvim-treesitter; config = toLuaFile ./lua/treesitter.lua; }

      { plugin = vimPlug.nvim-dap; config = toLuaFile ./lua/dap.lua; }
      vimPlug.nvim-dap-go
      vimPlug.nvim-dap-ui
      { plugin = vimPlug.persistent-breakpoints-nvim; config = toLua "require('persistent-breakpoints').setup{ load_breakpoints_event = { 'BufReadPost' }}"; }

      { plugin = vimPlug.nvim-cmp; config = toLuaFile ./lua/cmp.lua; }
      vimPlug.cmp-emoji
      vimPlug.cmp-buffer
      vimPlug.cmp-path
      vimPlug.cmp-cmdline
      vimPlug.cmp-nvim-lsp

      { plugin = vimPlug.vim-easy-align; config = toLuaFile ./lua/easyalign.lua; }

      vimPlug.vim-fugitive
      vimPlug.vim-gitgutter

      { plugin = vimPlug.barbar-nvim; config = toLuaFile ./lua/barbar.lua; }

      { plugin = vimPlug.persisted-nvim; config = toLuaFile ./lua/persisted.lua; }

      { plugin = vimPlug.ale; config = toLuaFile ./lua/ale.lua; }
      { plugin = vimPlug.vim-go; config = toLuaFile ./lua/vimgo.lua; }
      { plugin = vimPlug.vim-DetectSpellLang; config = toLuaFile ./lua/spelllang.lua; }

      { plugin = vimPlug.telescope-nvim; config = toLuaFile ./lua/telescope.lua; }
      { plugin = vimPlug.indent-blankline-nvim; config = toLua "require('ibl').setup({ scope = { enabled = false }})"; }

      vimPlug.plenary-nvim
      vimPlug.vim-visual-multi

      vimPlug.ultisnips
      vimPlug.cmp-nvim-ultisnips
    ];
    extraLuaConfig = builtins.readFile ./lua/options.lua;
  };
}

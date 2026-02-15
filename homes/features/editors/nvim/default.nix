{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    clang
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
    ".local/share/nvim/site/spell/de.utf-8.spl".source = builtins.fetchurl {
      url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
      sha256 = "sha256:1ld3hgv1kpdrl4fjc1wwxgk4v74k8lmbkpi1x7dnr19rldz11ivk";
    };
  };

  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    vimPlug = pkgs.vimPlugins;
    languages = [
      "arduino"
      "awk"
      "bash"
      "c"
      "comment"
      "css"
      "csv"
      "diff"
      "dockerfile"
      "gitcommit"
      "git_config"
      "gitignore"
      "git_rebase"
      "go"
      "gotmpl"
      "html"
      "javascript"
      "json"
      "kcl"
      "lua"
      "make"
      "markdown"
      "markdown_inline"
      "mermaid"
      "nginx"
      "nix"
      "nu"
      "promql"
      "python"
      "regex"
      "sql"
      "sql"
      "toml"
      "vim"
      "vimdoc"
      "yaml"
    ];
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
      vimPlug.lsp_signature-nvim

      vimPlug.playground
      { plugin = vimPlug.nvim-treesitter; config = toLuaFile ./lua/treesitter.lua; }

      { plugin = vimPlug.nvim-dap; config = toLuaFile ./lua/dap.lua; }
      vimPlug.nvim-dap-go
      vimPlug.nvim-dap-ui
      { plugin = vimPlug.persistent-breakpoints-nvim; config = toLua "require('persistent-breakpoints').setup{ load_breakpoints_event = { 'BufReadPost' }}"; }

      { plugin = vimPlug.nvim-cmp; config = toLuaFile ./lua/cmp.lua; }
      vimPlug.cmp-buffer
      vimPlug.cmp-calc
      vimPlug.cmp-cmdline
      vimPlug.cmp-emoji
      vimPlug.cmp-nvim-lsp
      vimPlug.cmp-path
      vimPlug.cmp-spell

      { plugin = vimPlug.vim-easy-align; config = toLuaFile ./lua/easyalign.lua; }

      vimPlug.vim-fugitive
      vimPlug.vim-gitgutter

      { plugin = vimPlug.barbar-nvim; config = toLuaFile ./lua/barbar.lua; }

      { plugin = vimPlug.persisted-nvim; config = toLuaFile ./lua/persisted.lua; }

      { plugin = vimPlug.ale; config = toLuaFile ./lua/ale.lua; }
      { plugin = vimPlug.vim-go; config = toLuaFile ./lua/vimgo.lua; }

      { plugin = vimPlug.telescope-nvim; config = toLuaFile ./lua/telescope.lua; }
      { plugin = vimPlug.indent-blankline-nvim; config = toLua "require('ibl').setup({ scope = { enabled = false }})"; }

      vimPlug.vim-visual-multi
      { plugin = vimPlug.nvim-surround; config = toLua "require('nvim-surround').setup()"; }

      vimPlug.ultisnips
      vimPlug.cmp-nvim-ultisnips
    ] ++ builtins.map (lang: vimPlug.nvim-treesitter-parsers."${lang}") languages;
    extraLuaConfig = builtins.readFile ./lua/options.lua;
  };
}

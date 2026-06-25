{ lib, config, pkgs, ... }:

{
  options.features.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf config.features.nvim.enable {
    home.packages = with pkgs; [
      ast-grep
      clang
      gopls
      helm-ls
      hunspell
      lua-language-server
      marksman
      nixd
      bash-language-server
      vscode-json-languageserver
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
        "toml"
        "vim"
        "vimdoc"
        "yaml"
      ];
    in {
      enable = true;
      defaultEditor = true;
      withRuby = false;
      withPython3 = true;
      viAlias = false;
      vimAlias = true;
      vimdiffAlias = true;
      plugins =  [
        { plugin = vimPlug.gruvbox-nvim; type = "lua"; config = "vim.cmd.colorscheme('gruvbox')"; }
        vimPlug.nvim-web-devicons

        { plugin = vimPlug.nvim-lspconfig; type = "lua"; config = builtins.readFile ./lua/lsp.lua; }
        vimPlug.lsp_signature-nvim

        { plugin = vimPlug.nvim-treesitter; type = "lua"; config = builtins.readFile ./lua/treesitter.lua; }

        { plugin = vimPlug.nvim-dap; type = "lua"; config = builtins.readFile ./lua/dap.lua; }
        vimPlug.nvim-dap-go
        vimPlug.nvim-dap-ui
        { plugin = vimPlug.persistent-breakpoints-nvim; type = "lua"; config = "require('persistent-breakpoints').setup{ load_breakpoints_event = { 'BufReadPost' }}"; }

        { plugin = vimPlug.nvim-cmp; type = "lua"; config = builtins.readFile ./lua/cmp.lua; }
        vimPlug.cmp-buffer
        vimPlug.cmp-calc
        vimPlug.cmp-cmdline
        vimPlug.cmp-emoji
        vimPlug.cmp-nvim-lsp
        vimPlug.cmp-path
        vimPlug.cmp-spell

        { plugin = vimPlug.vim-easy-align; type = "lua"; config = builtins.readFile ./lua/easyalign.lua; }

        vimPlug.vim-fugitive
        vimPlug.vim-gitgutter

        { plugin = vimPlug.barbar-nvim; type = "lua"; config = builtins.readFile ./lua/barbar.lua; }

        { plugin = vimPlug.persisted-nvim; type = "lua"; config = builtins.readFile ./lua/persisted.lua; }

        { plugin = vimPlug.ale; type = "lua"; config = builtins.readFile ./lua/ale.lua; }

        { plugin = vimPlug.telescope-nvim; type = "lua"; config = builtins.readFile ./lua/telescope.lua; }
        { plugin = vimPlug.indent-blankline-nvim; type = "lua"; config = "require('ibl').setup({ scope = { enabled = false }})"; }

        vimPlug.vim-visual-multi
        { plugin = vimPlug.nvim-surround; type = "lua"; config = "require('nvim-surround').setup()"; }

        vimPlug.ultisnips
        vimPlug.cmp-nvim-ultisnips
      ] ++ builtins.map (lang: vimPlug.nvim-treesitter-parsers."${lang}") languages;
      initLua = builtins.readFile ./lua/options.lua;
    };
  };
}

{ ... }:

{
  home.file.".config/ghostty/shaders".source = builtins.fetchGit {
    url = "https://github.com/sahaj-b/ghostty-cursor-shaders.git";
    rev = "4faa83e4b9306750fc8de64b38c6f53c57862db8";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "gruvbox-dark";
      font-family             = "JetBrainsMono Nerd Font Mono";
      font-family-bold        = "JetBrainsMono Nerd Font Mono Bold";
      font-family-italic      = "JetBrainsMono Nerd Font Mono Italic";
      font-family-bold-italic = "JetBrainsMono Nerd Font Mono Bold Italic";
      font-size = 16;
      cursor-style = "bar";
      custom-shader = [
        "shaders/cursor_warp.glsl"
        "shaders/ripple_cursor.glsl"
      ];
      window-decoration = "server";
      shell-integration-features = "no-title";
      title = "   ";
      keybind = [
          "ctrl+plus=ignore"
          "ctrl+minus=ignore"
          "ctrl+shift+plus=increase_font_size:2"
          "ctrl+shift+minus=decrease_font_size:2"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
      ];
    };

    themes = {
      gruvbox-dark = {
        foreground = "#ebdbb2";
        background = "#282828";
        selection-foreground = "#655b53";
        selection-background = "#ebdbb2";
        palette = [
          # black
          "0=#282828"
          "8=#928374"
          # red
          "1=#cc241d"
          "9=#fb4934"
          # green
          "2=#98971a"
          "10=#b8bb26"
          # yellow
          "3=#d79921"
          "11=#fabd2f"
          # blue
          "4=#458588"
          "12=#83a598"
          # purple
          "5=#b16286"
          "13=#d3869b"
          # aqua
          "6=#689d6a"
          "14=#8ec07c"
          # white
          "7=#a89984"
          "15=#ebdbb2"
          # grey
          "237=#3c3836"
        ];
      };
    };
  };
}

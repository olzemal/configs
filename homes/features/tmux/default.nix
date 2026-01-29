{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'everforest'
          set -g @tmux_power_right_arrow_icon    ''
          set -g @tmux_power_left_arrow_icon     ''
          set -g @tmux_power_show_user    false
          set -g @tmux_power_show_host    false
          set -g @tmux_power_show_session false
        '';
      }
    ];
  };
}

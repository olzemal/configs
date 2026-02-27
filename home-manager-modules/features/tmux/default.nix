{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = minimal-tmux-status;
        extraConfig = ''
          set -g status-interval 1

          set -g @minimal-tmux-fg "colour0"
          set -g @minimal-tmux-bg "colour12"
          set -g @minimal-tmux-justify "left"
          set -g @minimal-tmux-indicator false

          set -g @minimal-tmux-status "top"
          set -g @minimal-tmux-left false
          set -g @minimal-tmux-right true
          set -g @minimal-tmux-status-right "#[bg=colour0]#[fg=colour12]#[bg=colour12]#[fg=colour0]%d.%m.%Y %H:%M#[bg=colour0]#[fg=colour12]"

          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-right-arrow ""
          set -g @minimal-tmux-left-arrow ""

        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}

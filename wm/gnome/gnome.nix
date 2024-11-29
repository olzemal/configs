{ lib, pkgs, ... }:

with lib.hm.gvariant;
{
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    caffeine
    dash-to-dock
    emoji-copy
    just-perfection
    tailscale-qs
  ];

  home.sessionVariables.GTK_THEME = "Gruvbox-Dark";

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.papirus-icon-theme.override { color = "brown"; });
    };
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/input-sources" = {
       mru-sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       per-window = false;
       sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       xkb-options = ["caps:swapescape" "lv3:ralt_switch"];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      show-battery-percentage = true;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.43;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "just-perfection-desktop@just-perfection"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "tailscale@joaophi.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "qtpass.desktop"
        "kitty.desktop"
        "obsidian.desktop"
        "spotify.desktop"
        "org.gnome.Nautilus.desktop"
        "signal-desktop.desktop"
        "discord.desktop"
        "slack.desktop"
        "net.lutris.Lutris.desktop"
        "betaflight-configurator.desktop"
        "blender.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      power-saver-profile-on-low-battery = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/desktop/wm/keybindings" = {
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-workspace-left = ["<Shift><Super>Left"];
      move-to-workspace-right = ["<Shift><Super>Right"];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
      switch-to-workspace-left = ["<Super>Left"];
      switch-to-workspace-right = ["<Super>Right"];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = false;
      activities-button = false;
      activities-button-icon-monochrome = false;
      activities-button-label = false;
      alt-tab-window-preview-size = 0;
      animation = 3;
      app-menu = false;
      app-menu-icon = true;
      app-menu-label = true;
      background-menu = true;
      calendar = true;
      clock-menu = true;
      clock-menu-position = 0;
      clock-menu-position-offset = 0;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-app-running = true;
      dash-icon-size = 0;
      dash-separator = true;
      events-button = false;
      hot-corner = false;
      looking-glass-width = 0;
      notification-banner-position = 0;
      osd = true;
      osd-position = 0;
      panel = true;
      panel-arrow = true;
      panel-button-padding-size = 0;
      panel-corner-size = 0;
      panel-icon-size = 0;
      panel-in-overview = true;
      panel-indicator-padding-size = 0;
      panel-notification-icon = true;
      panel-size = 0;
      power-icon = true;
      quick-settings = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      show-prefs-intro = false;
      startup-status = 0;
      theme = false;
      top-panel-position = 0;
      weather = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      window-preview-caption = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-peek = true;
      workspace-popup = true;
      workspace-switcher-should-show = true;
      workspace-switcher-size = 0;
      workspace-wrap-around = false;
      workspaces-in-app-grid = true;
      world-clock = false;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
       apply-custom-theme = false;
       background-color = "rgb(40,40,40)";
       transparency-mode = "DYNAMIC";
       custom-background-color = true;
       custom-theme-shrink = true;
       dash-max-icon-size = 48;
       disable-overview-on-startup = true;
       dock-position = "BOTTOM";
       extend-height = false;
       height-fraction = 0.90000000000000002;
       hot-keys = false;
       icon-size-fixed = true;
       intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
       preferred-monitor = -2;
       preferred-monitor-by-connector = "eDP-1";
       preview-size-scale = 0.0;
       running-indicator-style = "DOTS";
       show-apps-always-in-the-edge = true;
       show-apps-at-top = true;
       show-trash = false;
     };
    "org/gnome/shell/extensions/blur-my-shell" = {
      appfolder-blur = false;
      brightness = 0.69999999999999996;
      color-and-noise = false;
      hacks-level = 0;
      noise-amount = 0.0;
      noise-lightness = 0.0;
      overview-brightness = 1.0;
      overview-customize = false;
      overview-sigma = 8;
      panel-static-blur = true;
      panel-unblur-in-overview = true;
      sigma = 6;
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = false;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}

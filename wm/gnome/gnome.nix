{ lib, pkgs, ... }:

with lib.hm.gvariant;
{
  home.packages = with pkgs.gnomeExtensions; [
    just-perfection
    caffeine
    emoji-copy
    tailscale-qs
    dash-to-dock
    blur-my-shell
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/input-sources" = {
       current = mkUint32 0;
       mru-sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       per-window = false;
       sources = [ (mkTuple [ "xkb" "us+alt-intl" ]) (mkTuple [ "xkb" "de" ]) ];
       xkb-options = ["caps:swapescape" "lv3:ralt_switch"];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.43;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "tailscale@joaophi.github.com"
        "just-perfection-desktop@just-perfection"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
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
        "org.gnome.Settings.desktop"
        "blender.desktop"
      ];
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
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
       background-opacity = 0.90000000000000002;
       custom-background-color = true;
       custom-theme-shrink = true;
       dash-max-icon-size = 48;
       disable-overview-on-startup = false;
       dock-position = "BOTTOM";
       extend-height = false;
       height-fraction = 0.90000000000000002;
       hot-keys = false;
       icon-size-fixed = true;
       intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
       preferred-monitor = -2;
       preferred-monitor-by-connector = "eDP-1";
       preview-size-scale = 0.0;
       running-indicator-style = "DEFAULT";
       show-apps-always-in-the-edge = true;
       show-apps-at-top = true;
       show-trash = false;
       transparency-mode = "FIXED";
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
      blur = true;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}

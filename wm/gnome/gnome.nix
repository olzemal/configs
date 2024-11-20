{ lib, pkgs, ... }:

with lib.hm.gvariant;
{
  home.packages = with pkgs.gnomeExtensions; [
    just-perfection
    caffeine
    emoji-copy
    quick-settings-tweaker
    tailscale-qs
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
        "expresslrs-configurator.desktop"
        "org.gnome.Settings.desktop"
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
  };
}

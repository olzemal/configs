{ lib, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "qtpass.desktop"
        "kitty.desktop"
        "obsidian.desktop"
        "org.gnome.Nautilus.desktop"
        "element-desktop.desktop"
        "slack.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
  };
}

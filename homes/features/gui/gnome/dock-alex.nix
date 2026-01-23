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
        "chrome-cinhimbnkkaeohfgghhklpknlkffjgod-Default.desktop"
        "net.lutris.Lutris.desktop"
        "com.moonlight_stream.Moonlight.desktop"
        "org.gnome.Nautilus.desktop"
        "signal-desktop.desktop"
        "discord.desktop"
        "slack.desktop"
        "chrome-iadnoobhlbjkjgjddpaopeaiejghgegg-Default.desktop"
        "chrome-ecncjmpdddaohegghdgbiblpacgaehib-Default.desktop"
        "betaflight-configurator.desktop"
        "org.freecad.FreeCAD.desktop"
        "OrcaSlicer.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
  };
}
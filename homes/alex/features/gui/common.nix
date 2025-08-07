{ unstable, ... }:

{
  home.packages = with unstable; [
    discord
    gimp
    inkscape
    obsidian
    qtpass
    signal-desktop
    slack
    spotify
  ];
}

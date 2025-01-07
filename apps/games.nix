{ unstable, ... }:

{
  home.packages = with unstable;[
    lutris
    wine64
    winetricks

    steam
    vcv-rack
  ];
}

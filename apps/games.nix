{ unstable, ... }:

{
  home.packages = with unstable;[
    lutris
    steam
    vcv-rack
  ];
}

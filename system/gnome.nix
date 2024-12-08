{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager = {
    gdm.enable = true;
    gnome.enable = true;
  };
}

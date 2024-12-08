{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

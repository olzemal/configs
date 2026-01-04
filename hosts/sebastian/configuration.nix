{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ../common

      ../features/ssh.nix
      ../features/traefik.nix
    ];

  networking.hostName = "sebastian";
  networking.domain = "";

  services.headscale = {
    enable = true;
    address = "[::]";
    port = 20002;
    settings = {
      server_url = "https://headscale.olzemal.de";
      dns.base_domain = "hs.olzemal.de";
    };
  };

  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];
  };

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];

  security.sudo.wheelNeedsPassword = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

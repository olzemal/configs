{ inputs, config, pkgs, ... }:

{
  imports =
    [
      inputs.sops-nix.nixosModules.sops

      ./hardware-configuration.nix
      ./networking.nix

      ../common
      ../features/traefik.nix
      ../features/ssh.nix
    ];

  networking.hostName = "sebastian";
  networking.domain = "";

  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];
  };

  nix.settings.trusted-users = [ "root" ] ++ (builtins.attrNames config.users.users);

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];

  security.sudo.wheelNeedsPassword = false;

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/alex/.age/key.txt";
  };

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

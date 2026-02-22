{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ../common
      ./hardware-configuration.nix

      ../features/fonts.nix
      ../features/gnome.nix
      ../features/x11.nix
    ];

  networking.hostName = "nixvm";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.networkmanager.enable = true;

  users.users = {
    alex = {
      isNormalUser = true;
      description = "Alex";
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.trusted-users = [ "root" ] ++ (builtins.attrNames config.users.users);

  services.openssh.enable = true;
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}

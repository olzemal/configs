{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system/system.nix
      ../../system/locale.nix

      ../../system/x11.nix
      ../../system/gnome.nix

      ../../system/appimage.nix
      ../../system/direnv.nix
      ../../system/docker.nix
      ../../system/fonts.nix
      ../../system/gpg.nix
      ../../system/ssh.nix
      ../../system/syncthing.nix
      ../../system/tailscale.nix
    ];

  networking.hostName = "carbon"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    hunspell

    chromium
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

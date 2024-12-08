{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/system.nix
      ./system/locale.nix

      ./system/x11.nix

      ./system/syncthing.nix
      ./system/ssh.nix
      ./system/tailscale.nix
    ];

  networking.hostName = "carbon"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    blender
    chromium
    discord
    home-manager
    hunspell
    kitty
    lutris
    nerdfonts
    obsidian
    qtpass
    signal-desktop
    slack
    spotify

    bat
    dig
    direnv
    fzf
    gh
    gojq
    htop
    hugo
    k9s
    kind
    kubectl
    kubernetes-helm
    minikube
    pass
    pre-commit
    semver
    tree
    trivy
    wget
    yq-go
    zoxide

    gdc
    go
    python3
    shellcheck
  ];

  fonts = {
    packages = with pkgs; [ nerdfonts ];
    fontDir.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.direnv.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

{ config, pkgs, ... }:

{
  imports =
    [
      ../common
      ./hardware-configuration.nix

      ../features/appimage.nix
      ../features/docker.nix
      ../features/fonts.nix
      ../features/gnome.nix
      ../features/steam.nix
      ../features/syncthing.nix
      ../features/tailscale.nix
      ../features/x11.nix
    ];

  networking.hostName = "carbon";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "i915.enable_psr=0"
    "i915.enable_fbc=0"
    "i915.enable_dc=0"
    "i915.disable_power_well=1"
  ];

  boot.blacklistedKernelModules = [ "cdc_ncm" ];

  boot.kernelModules = [
    "r8152"
  ];

  networking.networkmanager.enable = true;

  users.users = {
    alex = {
      isNormalUser = true;
      description = "Alex";
      extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];
    };
    work = {
      isNormalUser = true;
      description = "Alex work";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
  };

  services.udev.extraRules = ''
    # DFU (Internal bootloader for STM32 and AT32 MCUs)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
  '';

  services.udev.packages = [
    (pkgs.writeTextDir "lib/udev/rules.d/70-stm32-dfu.rules" ''
      # DFU (Internal bootloader for STM32 and AT32 MCUs)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
    '')
  ];

  services.fwupd.enable = true;

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;

      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

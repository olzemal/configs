{ lib, config, pkgs, ... }:

{
  options.features.desktop = {
    enable = lib.mkEnableOption "desktop";
    gnome.enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf config.features.desktop.enable {
    services.xserver.enable = true;
    hardware.graphics.enable = true;

    services.xserver.xkb = {
      layout = "de,us";
      variant = "";
      options = "compose:ralt";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    fonts = {
      packages = with pkgs.nerd-fonts; [
        hack
        iosevka
        jetbrains-mono
      ];
      fontDir.enable = true;
    };

    services.displayManager.gdm.enable = true;

    features.desktop.gnome.enable = lib.mkDefault true;
    services.desktopManager.gnome.enable = config.features.desktop.gnome.enable;
  };
}

{ lib, config, pkgs, ... }:

{
  imports = [
    ./terminals
  ];

  options.features.desktopapps = {
    enable = lib.mkEnableOption "desktopapps";
    image-editing.enable = lib.mkEnableOption "image-editing";
    gaming.enable = lib.mkEnableOption "gaming";
    element.enable = lib.mkEnableOption "element";
  };

  config = lib.mkIf config.features.desktopapps.enable {
    home.packages = with pkgs; [
      obsidian
      qtpass
      signal-desktop
    ] ++ lib.optionals config.features.desktopapps.image-editing.enable [
      gimp
      inkscape
    ] ++ lib.optionals config.features.desktopapps.gaming.enable [
      discord
      lutris
      moonlight-qt
      wine64
      winetricks
    ];

    programs.element-desktop.enable = config.features.desktopapps.element.enable;
    systemd.user.services.element-desktop = lib.mkIf config.programs.element-desktop.enable {
      Unit = {
        Description = "Element Desktop";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${config.element-desktop.package}/bin/element-desktop";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}

{ lib, config, pkgs, ... }:

let
  mkChromiumApp = name: url: icon:
  {
    executable = true;
    text = ''
       #!/usr/bin/env xdg-open
       [Desktop Entry]
       Version=1.0
       Terminal=false
       Type=Application
       Name=${name}
       Exec=${pkgs.chromium}/bin/chromium --ozone-platform=wayland --app=${url}
       Icon=${icon}
     '';
  };
in
{
  imports = [
    ./terminals
    ./vscode
    ./fpv
  ];

  options.features.desktopapps = {
    enable = lib.mkEnableOption "desktopapps";
    image-editing.enable = lib.mkEnableOption "image-editing";
    gaming.enable = lib.mkEnableOption "gaming";
    element.enable = lib.mkEnableOption "element";
    youtube-music.enable = lib.mkEnableOption "youtube-music";
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

    programs.element-desktop.enable = lib.mkIf config.features.desktopapps.element.enable true;
    systemd.user.services.element-desktop = lib.mkIf config.programs.element-desktop.enable {
      Unit = {
        Description = "Element Desktop";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${config.programs.element-desktop.package}/bin/element-desktop";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    features.chromium.enable = lib.mkIf config.features.desktopapps.youtube-music.enable true;
    home.file.".local/share/applications/youtube-music.desktop" = lib.mkIf config.features.desktopapps.youtube-music.enable
      (mkChromiumApp "Youtube-Music" "https://music.youtube.com" ../../../assets/icons/youtube-music.png);

    features.gnome.dock-apps = lib.mkBefore (lib.optionals config.features.desktopapps.youtube-music.enable [
      "youtube-music.desktop"
    ] ++ lib.optionals config.features.desktopapps.element.enable [
      "element-desktop.desktop"
    ] ++ lib.optionals config.features.desktopapps.gaming.enable [
      "discord.desktop"
      "net.lutris.Lutris.desktop"
      "com.moonlight_stream.Moonlight.desktop"
    ]);
  };
}

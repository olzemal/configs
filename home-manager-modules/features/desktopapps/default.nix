{ lib, config, pkgs, ... }:

let
  types = lib.types;
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
  mkAutostart = name: bin:
  {
    Unit = {
      Description = "${name}";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${bin}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  imports = [
    ./terminals
    ./vscode
    ./fpv
    ./vcv-rack
  ];

  options.features.desktopapps = {
    enable = lib.mkEnableOption "desktopapps";
    gaming.enable = lib.mkEnableOption "gaming";
    image-editing.enable = lib.mkEnableOption "image-editing";
    youtube-music.enable = lib.mkEnableOption "youtube-music";
    element = {
      enable = lib.mkEnableOption "element";
      autostart = lib.mkEnableOption "autostart of element";
    };
    teamspeak = {
      enable = lib.mkEnableOption "teamspeak";
      autostart = lib.mkEnableOption "autostart of teamspeak";
    };
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
    ] ++ lib.optionals config.features.desktopapps.teamspeak.enable [
      teamspeak6-client
    ];
    systemd.user.services.teamspeak6-client = lib.mkIf config.features.desktopapps.teamspeak.autostart
      (mkAutostart "Teamspeak 6 Client" "${pkgs.teamspeak6-client}/bin/TeamSpeak");

    programs.element-desktop.enable = lib.mkIf config.features.desktopapps.element.enable true;
    systemd.user.services.element-desktop = lib.mkIf config.features.desktopapps.element.autostart
      (mkAutostart "Element Desktop" "${config.programs.element-desktop.package}/bin/element-desktop");

    features.chromium.enable = lib.mkIf config.features.desktopapps.youtube-music.enable true;
    home.file.".local/share/applications/youtube-music.desktop" = lib.mkIf config.features.desktopapps.youtube-music.enable
      (mkChromiumApp "Youtube-Music" "https://music.youtube.com" ../../../assets/icons/youtube-music.png);

    features.gnome.dock-apps = lib.mkBefore (lib.optionals config.features.desktopapps.youtube-music.enable [
      "youtube-music.desktop"
    ] ++ lib.optionals config.features.desktopapps.element.enable [
      "element-desktop.desktop"
    ] ++ lib.optionals config.features.desktopapps.teamspeak.enable [
      "TeamSpeak.desktop"
    ] ++ lib.optionals config.features.desktopapps.gaming.enable [
      "discord.desktop"
      "net.lutris.Lutris.desktop"
      "com.moonlight_stream.Moonlight.desktop"
    ]);
  };
}

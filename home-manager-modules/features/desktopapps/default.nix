{ lib, config, pkgs, ... }:

let
  mkChromiumApp = name: url: iconurl: sha: let
    icon = builtins.fetchurl {
      name = "${name}.png";
      url = iconurl;
      sha256 = sha;
    };
  in
  {
    executable = true;
    text = ''
       #!/usr/bin/env xdg-open
       [Desktop Entry]
       Version=1.0
       Terminal=false
       Type=Application
       Name=${name}
       Exec=${pkgs.chromium}/bin/chromium --app=${url}
       Icon=${icon}
     '';
  };
in
{
  imports = [
    ./terminals
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

    features.desktopapps.youtube-music.enable = lib.mkDefault config.features.desktopapps.enable;
    features.chromium.enable = config.features.desktopapps.youtube-music.enable;
    home.file.".local/share/applications/youtube-music.desktop" = lib.mkIf config.features.desktopapps.youtube-music.enable
      (mkChromiumApp "youtube-music" "https://music.youtube.com"
        "https://music.youtube.com/img/favicon_96.png"
        "sha256:1lr6xx8yqh56fzv2zvmzhaj35dbql6r0xkxy6sf429xpba7b44a7");

    features.gnome.dock-apps = lib.optionals config.features.desktopapps.youtube-music.enable [
      "youtube-music.desktop"
    ] ++ lib.optionals config.features.desktopapps.element.enable [
      "element-desktop.desktop"
    ];
  };
}

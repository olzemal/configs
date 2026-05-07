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
  freecad-wrapper = pkgs.writeShellScriptBin "freecad-wrapper" ''
    XDG_DATA_DIRS="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:''${XDG_DATA_DIRS:-}" exec ${pkgs.freecad}/bin/freecad "$@"
  '';
in
{
  options.features.desktopapps.fpv.enable = lib.mkEnableOption "fpv";

  config = lib.mkIf config.features.desktopapps.fpv.enable {
    home.packages = with pkgs; [
      betaflight-configurator
      freecad
      freecad-wrapper
      orca-slicer
    ];

    home.file = let
      app-folder = ".local/share/applications";
    in
    {
      "${app-folder}/elrs-web-flasher.desktop" = mkChromiumApp "ELRS-Web-Flasher" "https://expresslrs.github.io/web-flasher" ../../../../assets/icons/elrs-configurator.png;
      "${app-folder}/esc-configurator.desktop" = mkChromiumApp "ESC-Configurator" "https://esc-configurator.com" ../../../../assets/icons/esc-configurator.png;
      "${app-folder}/edgetx-buddy.desktop"     = mkChromiumApp "EdgeTX-Buddy"     "https://buddy.edgetx.org" ../../../../assets/icons/edgetx.png;

      "${app-folder}/org.freecad.FreeCAD.desktop" = {
        executable = true;
        text = ''
          #!/usr/bin/env xdg-open
          [Desktop Entry]
          Name=FreeCAD
          Exec=${freecad-wrapper}/bin/freecad-wrapper %F
          Terminal=false
          Type=Application
          Icon=org.freecad.FreeCAD
        '';
      };
    };

    features.gnome.dock-apps = [
      "elrs-web-flasher.desktop"
      "esc-configurator.desktop"
      "edgetx-buddy.desktop"
      "betaflight-configurator.desktop"
      "org.freecad.FreeCAD.desktop"
      "OrcaSlicer.desktop"
    ];
  };
}

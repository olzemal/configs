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
  options.features.fpv.enable = lib.mkEnableOption "fpv";

  config = lib.mkIf config.features.fpv.enable {
    home.packages = with pkgs; [
      betaflight-configurator
      freecad
      orca-slicer
    ];

    features.chromium.enable = true;

    home.file = let
      app-folder = ".local/share/applications";
    in
    {
      "${app-folder}/elrs-web-flasher.desktop" = mkChromiumApp "ELRS-Web-Flasher" "https://expresslrs.github.io/web-flasher" ../../../assets/icons/elrs-configurator.png;
      "${app-folder}/esc-configurator.desktop" = mkChromiumApp "ESC-Configurator" "https://esc-configurator.com" ../../../assets/icons/esc-configurator.png;
      "${app-folder}/edgetx-buddy.desktop"     = mkChromiumApp "EdgeTX-Buddy"     "https://buddy.edgetx.org" ../../../assets/icons/edgetx.png;
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

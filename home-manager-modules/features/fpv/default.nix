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
  options.features.fpv.enable = lib.mkEnableOption "fpv";

  config = lib.mkIf config.features.fpv.enable {
    home.packages = with pkgs; [
      betaflight-configurator
      freecad
      orca-slicer
    ];

    features.chromium.enable = true;

    home.file = {
      ".local/share/applications/elrs-web-flasher.desktop" = mkChromiumApp "ELRS-Web-Flasher" "https://expresslrs.github.io/web-flasher"
        "https://github.com/ExpressLRS/ExpressLRS-Configurator/blob/92b4111ac146332be99b037cce4506a5b0b5bf68/assets/icons/96x96.png?raw=true" "sha256:07cqa1s7swmnxmlqs1w1ljymnldrmgi87xxdyz25kmylqns3ia54";
      ".local/share/applications/esc-configurator.desktop" = mkChromiumApp "ESC-Configurator" "https://esc-configurator.com"
        "https://esc-configurator.com/logo192.png" "sha256:08mqyma78ybymvv9637fji05dki410xa3i76hdk74pjw6yrj7n8a";
    };

    features.gnome.dock-apps = [
      "elrs-web-flasher.desktop"
      "esc-configurator.desktop"
      "betaflight-configurator.desktop"
      "org.freecad.FreeCAD.desktop"
      "OrcaSlicer.desktop"
    ];
  };
}

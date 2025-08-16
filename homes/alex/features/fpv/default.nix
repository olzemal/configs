{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      nwjs = prev.nwjs.overrideAttrs {
        version = "0.84.0";
        src = prev.fetchurl {
          url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
          hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
        };
      };
    })
  ];

  home.packages = with pkgs; [
    betaflight-configurator
    unstable.chromium
    unstable.freecad
    edge.orca-slicer
  ];

  home.file = {
    "Desktop/chrome-ecncjmpdddaohegghdgbiblpacgaehib-Default.desktop" = {
      executable = true;
      text = ''
        #!/usr/bin/env xdg-open
        [Desktop Entry]
        Version=1.0
        Terminal=false
        Type=Application
        Name=ExpressLRS Web Flasher
        Exec=chromium --profile-directory=Default --app-id=ecncjmpdddaohegghdgbiblpacgaehib
        Icon=chrome-ecncjmpdddaohegghdgbiblpacgaehib-Default
        StartupWMClass=crx_ecncjmpdddaohegghdgbiblpacgaehib
      '';
    };
    "Desktop/chrome-iadnoobhlbjkjgjddpaopeaiejghgegg-Default.desktop" = {
      executable = true;
      text = ''
        #!/usr/bin/env xdg-open
        [Desktop Entry]
        Version=1.0
        Terminal=false
        Type=Application
        Name=ESC Configurator
        Exec=chromium --profile-directory=Default --app-id=iadnoobhlbjkjgjddpaopeaiejghgegg
        Icon=chrome-iadnoobhlbjkjgjddpaopeaiejghgegg-Default
        StartupWMClass=crx_iadnoobhlbjkjgjddpaopeaiejghgegg
      '';
    };
  };
}

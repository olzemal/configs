{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.betaflight-configurator
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

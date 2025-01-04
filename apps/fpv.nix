{ unstable, pkgs, ... }:

{
  home.packages = [
    unstable.betaflight-configurator
    pkgs.chromium
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
  };
}

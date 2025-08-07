{ unstable, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      blender = prev.blender.overrideAttrs (old: {
        pythonPath = (old.pythonPath or []) ++ [unstable.python313Packages.py-slvs];
      });
    })
  ];

  home.packages = with unstable; [
    betaflight-configurator
    chromium
#    orca-slicer  # https://github.com/NixOS/nixpkgs/issues/429433
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

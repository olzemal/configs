{ lib, config, pkgs, ... }:

let
  version = "2.6.6";

  vcv-rack = pkgs.stdenv.mkDerivation {
    pname = "vcv-rack";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://vcvrack.com/downloads/RackFree-${version}-lin-x64.zip";
      hash = "sha256-aazwyY1H2zgSkaEV1gnc+7mYh7172GQfBInaBj+w/G4=";
    };

    nativeBuildInputs = [ pkgs.unzip pkgs.makeWrapper ];

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/opt $out/bin
      cp -r Rack2Free $out/opt/
      makeWrapper ${pkgs.steam-run}/bin/steam-run $out/bin/Rack --chdir "$out/opt/Rack2Free" --add-flags "./Rack"
      runHook postInstall
    '';

    meta = with pkgs.lib; {
      description = "Virtual Eurorack Studio";
      homepage = "https://vcvrack.com";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  options.features.desktopapps.vcv-rack.enable = lib.mkEnableOption "vcv-rack";

  config = lib.mkIf config.features.desktopapps.vcv-rack.enable {
    home.packages = [ vcv-rack ];

    home.file.".local/share/applications/Rack.desktop" = {
      executable = true;
      text = ''
        [Desktop Entry]
        Version=1.0
        Terminal=false
        Type=Application
        Name=VCV Rack
        Exec=${vcv-rack}/bin/Rack
        Icon=${vcv-rack}/opt/Rack2Free/res/icon.png
      '';
    };
  };
}

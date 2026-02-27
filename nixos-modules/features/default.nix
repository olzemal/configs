{ lib, config, ... }:

{
  imports = [
    ./desktop.nix
    ./qemu.nix
    ./ssh.nix
    ./syncthing.nix
    ./traefik.nix
    ./zitadel.nix
  ];

  options.features = {
    appimage.enable = lib.mkEnableOption "appimage";
    docker.enable = lib.mkEnableOption "docker";
    tailscale-client.enable = lib.mkEnableOption "tailscale";
  };

  config = {
    programs.appimage = lib.mkIf config.features.appimage.enable {
      enable = true;
      binfmt = true;
    };
    virtualisation.docker.enable = config.features.docker.enable;
    services.tailscale.enable = config.features.tailscale-client.enable;
  };
}

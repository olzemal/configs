{ lib, config, pkgs, ... }:

let
  types = lib.types;
in
{
  options.features.traefik = {
    enable = lib.mkEnableOption "traefik";
    letsencrypt = {
      email = lib.mkOption { type = types.str; };
      provider = lib.mkOption { type = types.str; };
      resolvers = lib.mkOption { type = types.listOf types.str; };
    };
  };

  config = lib.mkIf config.features.traefik.enable {
    services.traefik = {
      enable = true;

      package = pkgs.traefik;

      staticConfigOptions = {
        log.level = "WARN";

        entryPoints = {
          web = {
            address = "[::]:80";
            http.redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure = {
            address = "[::]:443";
          };
        };

        certificatesResolvers = {
          hetzner = {
            acme = {
              email = config.features.traefik.letsencrypt.email;
              storage = "/var/lib/traefik/acme.json";
              caserver = "https://acme-v02.api.letsencrypt.org/directory";
              dnsChallenge = {
                provider = config.features.traefik.letsencrypt.provider;
                resolvers = config.features.traefik.letsencrypt.resolvers;
              };
            };
          };
        };
      };
    };

    sops.secrets."traefik/env" = {
      owner = config.systemd.services.traefik.serviceConfig.User;
      group = config.services.traefik.group;
      mode = "0440";
    };

    systemd.services.traefik.serviceConfig = {
      EnvironmentFile = [ config.sops.secrets."traefik/env".path ];
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}

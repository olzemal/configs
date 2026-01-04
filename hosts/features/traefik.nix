{ config, pkgs, ... }:

{
  services.traefik = {
    enable = true;

    package = pkgs.unstable.traefik;

    staticConfigOptions = {
      log.level = "WARN";
      api = {};
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
            email = "olzemal+letsencrypt@gmail.com";
            storage = "/var/lib/traefik/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "hetzner";
              resolvers = [ "hydrogen.ns.hetzner.com." "dns.hetzner.com." ];
            };
          };
        };
      };
    };

    dynamicConfigOptions = {

    };
  };

  systemd.services.traefik.serviceConfig = {
    EnvironmentFile = [ "/var/lib/traefik/env" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

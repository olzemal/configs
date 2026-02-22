{ config, pkgs, ... }:

{
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

    dynamicConfigOptions.http = {
      routers.root = {
        rule = "Host(`olzemal.de`)";
        entrypoints = "websecure";
        tls.certResolver = "hetzner";
        middlewares = [ "github-redirect" ];
        service = "root";
      };

      services."root" = {
        loadBalancer.servers = [ { url = "http://localhost:80"; } ];
      };

      middlewares."github-redirect" = {
        redirectRegex = {
          regex = "olzemal.de/(.*)";
          replacement = "github.com/olzemal/\${1}";
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
}

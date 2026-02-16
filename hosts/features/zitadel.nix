{ config, pkgs, ... }:

let
  domain = "olzemal.de";
in
{
  sops.secrets = {
    "zitadel/master-key" = {
      owner = config.services.zitadel.user;
      group = config.services.zitadel.group;
      mode = "0440";
    };
    "zitadel/admin-steps" = {
      owner = config.services.zitadel.user;
      group = config.services.zitadel.group;
      mode = "0440";
    };
    "zitadel/extra-settings" = {
      owner = config.services.zitadel.user;
      group = config.services.zitadel.group;
      mode = "0440";
    };
    "zitadel/postgres-env" = { };
  };

  services.zitadel = {
    enable = true;
    masterKeyFile = config.sops.secrets."zitadel/master-key".path;
    extraSettingsPaths = [ config.sops.secrets."zitadel/extra-settings".path ];
    extraStepsPaths = [ config.sops.secrets."zitadel/admin-steps".path ];

    tlsMode = "external";
    settings = {
      Port = 39995;
      ExternalPort = 443;
      ExternalDomain = "auth.${domain}";
      Database = {
        postgres = {
          Host = "127.0.0.1";
          Port = 5432;
          Database = "zitadel";
          MaxOpenConns = 15;
          MaxIdleConns = 10;
          MaxConnLifetime = "1h";
          MaxConnIdleTime = "5m";
        };
      };
    };
  };

  virtualisation.oci-containers.backend = "podman";
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.zitadel-db = {
    image = "postgres:17";  # 18 is not supported yet
    ports = [ "5432:5432" ];
    environmentFiles = [
      config.sops.secrets."zitadel/postgres-env".path
    ];
    volumes = [
      "/var/lib/zitadel-db:/var/lib/postgresql/data"
    ];
  };

  system.activationScripts.makeZitadelDir = pkgs.lib.stringAfter [ "var" ] ''
    mkdir -p /var/lib/zitadel-db
  '';

  services.traefik.dynamicConfigOptions.http = {
    routers.zitadel = {
      rule = "Host(`auth.${domain}`)";
      tls.certResolver = "hetzner";
      service = "zitadel";
      entrypoints = "websecure";
    };

    services.zitadel.loadBalancer.servers = [
      { url = "http://localhost:${toString config.services.zitadel.settings.Port}"; }
    ];
  };
}

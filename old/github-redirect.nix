{ ... }:

{
  services.traefik.dynamicConfigOptions.http = {
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
}

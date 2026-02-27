{ lib, config, ... }:

{
  options.features.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf config.features.ssh.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}

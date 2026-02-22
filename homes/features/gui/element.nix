{ pkgs, ... }:

{
  programs.element-desktop = {
    enable = true;
    package = pkgs.element-desktop;
  };

  # Auto-start Element on login
  systemd.user.services.element-desktop = {
    Unit = {
      Description = "Element Desktop";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.element-desktop}/bin/element-desktop";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

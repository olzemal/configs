{ lib, config, ... }:

let
  types = lib.types;
in
{
  options.features = {
    qemu = {
      enable = lib.mkEnableOption "qemu";
      users = lib.mkOption {
        type = types.listOf types.str;
        default = [];
      };
    };
  };

  config = lib.mkIf config.features.qemu.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = lib.mkIf config.features.desktop.enable true;
    users.users = builtins.listToAttrs (map (user: lib.nameValuePair user {
      extraGroups = [ "libvirtd" ];
    }) config.features.qemu.users);
  };
}

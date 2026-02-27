{ lib, config, ... }:

let
  types = lib.types;
in
{
  options.features = {
    qemu = {
      enable = lib.mkEnableOption "qemu";
      users = lib.mkOption { type = types.listOf types.str; };
    };
  };

  config = {
    virtualisation.libvirtd.enable = config.features.qemu.enable;
    programs.virt-manager.enable = config.features.qemu.enable && config.features.desktop.enable;
    users.users = builtins.listToAttrs (map (user: lib.nameValuePair user {
      extraGroups = [ "libvirtd" ];
    }) config.features.qemu.users);
  };
}

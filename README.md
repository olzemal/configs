# configs

My configuration files and shell scripts.

## Apply home-manager configuration

```console
$ home-manager switch --flake .#alex@laptop
```
## Apply NixOS configuration

```console
$ sudo nixos-rebuild switch --flake .#laptop
```

## Get home-manager for bootstrapping

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

$ nix-channel --update

$ nix-shell '<home-manager>' -A install
```

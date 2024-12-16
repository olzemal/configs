# configs

My configuration files and shell scripts.

## Get home-manager for bootstrapping

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

$ nix-channel --update

$ nix-shell '<home-manager>' -A install

$ home-manager switch --flake ./homes/<profile>#default
```

```console
$ sudo nixos-rebuild switch --flake .#default

$ home-manager switch --flake .
```

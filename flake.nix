{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
  let
    lib = nixpkgs.lib;
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });
  in
  {
    nixpkgs.overlays = [
      (final: prev: {
        nwjs = prev.nwjs.overrideAttrs {  # nwjs fix for betaflight
          version = "0.84.0";
          src = prev.fetchurl {
            url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
            hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
          };
        };
      })
    ];

    nixosConfigurations = {
      "vm" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./hosts/vm/configuration.nix
          self.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            features.desktop.enable = true;
            features.qemu = {
              enable = true;
              users = [ "alex" ];
            };

            users.users = {
              alex = {
                isNormalUser = true;
                description = "Alex";
                extraGroups = [ "networkmanager" "wheel" ];
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCj/abIX+hFRMuZoFWhMZDk9UYnnSy0LQB/aHpaCbnD" ];
              };
            };
            security.sudo.wheelNeedsPassword = false;
            nix.settings.trusted-users = [ "root" "alex"];
            services.openssh.enable = true;
            networking.firewall.enable = false;

            home-manager.useGlobalPkgs = true;
            home-manager.users.alex = {
              username = "alex";
              features = {
                gnome.enable = true;
                desktopapps.gaming.enable = true;
              };
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };

    homeModules.default = {
      imports = [
        ./home-manager-modules
      ];
    };

    nixosModules.default = {
      imports = [
        sops-nix.nixosModules.sops
        ./nixos-modules
      ];

      home-manager.sharedModules = [
        ./home-manager-modules
      ];
    };
  };
}

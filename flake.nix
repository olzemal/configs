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

    devenv = {
      url = "github:cachix/devenv?ref=v2.0.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, devenv, ... }@inputs:
  let
    lib = nixpkgs.lib;
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    overlays = [
      devenv.overlays.default
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
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
      overlays = overlays;
    });
  in
  {
    nixpkgs.overlays = overlays;

    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./hosts/laptop/configuration.nix
          self.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            features = {
              desktop = {
                enable = true;
                gnome.enable = true;
              };
              tailscale-client.enable = true;
              syncthing.enable = true;
              docker.enable = true;
              qemu = {
                enable = true;
                users = [ "alex" "work" ];
              };
            };

            users.users = {
              alex = {
                isNormalUser = true;
                description = "Alex";
                extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];
              };
              work = {
                isNormalUser = true;
                description = "Work";
                extraGroups = [ "networkmanager" "wheel" "docker" ];
              };
            };

            home-manager.useGlobalPkgs = true;
            home-manager.users = {
              alex = {
                username = "alex";
                features = {
                  gnome.enable = true;
                  desktopapps = {
                    enable = true;
                    gaming.enable = true;
                    image-editing.enable = true;
                    youtube-music.enable = true;
                    fpv.enable = true;
                  };
                  ai.opencode.enable = true;
                };
              };
              work = {
                username = "work";
                features = {
                  gnome.enable = true;
                  desktopapps = {
                    enable = true;
                    element.enable = true;
                    vscode.enable = true;
                  };
                  ai.opencode.enable = true;
                };
              };
            };
          }
          {
            nix.settings.substituters = [
              "https://devenv.cachix.org"
              "https://cache.nixos.org"
              "https://nix-community.cachix.org"
            ];

            nix.settings.trusted-public-keys = [
              "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      "vm" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./hosts/vm/configuration.nix
          self.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            features = {
              desktop = {
                enable = true;
                gnome.enable = true;
              };
              tailscale-client.enable = true;
              docker.enable = true;
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
            home-manager.users = {
              alex = {
                username = "alex";
                features = {
                  gnome.enable = true;
                  desktopapps = {
                    enable = true;
                    gaming.enable = true;
                    image-editing.enable = true;
                    youtube-music.enable = true;
                    fpv.enable = true;
                    vscode.enable = true;
                  };
                };
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

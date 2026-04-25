{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, sops-nix, ... }@inputs:
  let
    lib = nixpkgs.lib;
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    overlays = [
      (final: prev: {
        nwjs = prev.nwjs.overrideAttrs {  # nwjs fix for betaflight
          version = "0.84.0";
          src = prev.fetchurl {
            url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
            hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
          };
        };
        devenv = (import unstable {system = prev.system;}).devenv;
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
                  bash.enable = true;
                  nvim.enable = true;
                  gnome.enable = true;
                  desktopapps = {
                    enable = true;
                    ghostty.enable = true;
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
                  bash.enable = true;
                  nvim.enable = true;
                  gnome.enable = true;
                  desktopapps = {
                    enable = true;
                    ghostty.enable = true;
                    element.enable = true;
                    vscode.enable = true;
                  };
                  ai.opencode.enable = true;
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

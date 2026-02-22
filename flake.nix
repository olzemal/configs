{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
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
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./hosts/laptop/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      "sebastian" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./hosts/sebastian/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      "vm" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/vm/configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.alex = { imports = [ ./homes/alex.nix ]; };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}

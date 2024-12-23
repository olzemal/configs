{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "carbon";
    };

    pkgs = import inputs.nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    unstable = import inputs.unstable {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };
  in
  {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit unstable;
        };
      };
    };

    homeConfigurations = {
      "alex" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ../../homes/private/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit unstable;
        };
      };
    };
  };
}

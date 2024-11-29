{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
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
  in
  {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      "alex" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}

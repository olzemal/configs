{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "alex" = home-manager.lib.homeManagerConfiguration {
        specialArgs = { inherit inputs; };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}

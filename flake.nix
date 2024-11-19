#{
#  description = "My flake";
#
#  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
#    stylix.url = "github:danth/stylix";
#  };
#
#  outputs = { nixpkgs, home-manager, stylix, ... }@inputs: {
#    nixosConfigurations = {
#      default = nixpkgs.lib.nixosSystem {
#        specialArgs = { inherit inputs; };
#        modules = [
#          ./configuration.nix
#          inputs.stylix.nixosModules.stylix
#        ];
#      };
#    };
#  };
#}

{
  description = "My flake";

  inputs = {
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs: {
    homeConfigurations = {
      alex = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}

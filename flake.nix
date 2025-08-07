{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, unstable, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
    systems = ["x86_64-linux" "aarch64-linux"];
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });
    unstableFor = lib.genAttrs systems (system: import unstable {
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
          unstable = unstableFor.x86_64-linux;
        };
      };
    };

    homeConfigurations = {
      "alex@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        modules = [
          ./homes/alex/laptop.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          unstable = unstableFor.x86_64-linux;
        };
      };
#      "alex@work" = home-manager.lib.homeManagerConfiguration {
#        pkgs = pkgsFor.x86_64-linux;
#        modules = [
#          ./homes/alex/work.nix
#        ];
#        extraSpecialArgs = {
#          inherit unstable;
#        };
#      };
    };
  };
}

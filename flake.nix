{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, home-manager, darwin, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      homeConfiguration = {
        hanan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./modules/home.nix
            ./modules/fish.nix
            ./modules/starship.nix
          ];
        };
        # TODO Should Add Packages Or Module On Indodax Envirotment
        indodax = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./modules/home.nix
            ./modules/fish.nix
            ./modules/starship.nix
          ];
        };
      };

      darwinConfigurations."hanan" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/activation.nix
          ./modules/redis.nix
        ];
      };
    };
}


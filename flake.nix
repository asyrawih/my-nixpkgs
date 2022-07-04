{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, home-manager, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      homeConfiguration = {
        hanan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ({ pkgs, lib, ... }: {
              home.stateVersion = "22.05";
              home.username = "hanan";
              home.homeDirectory = "/Users/hanan";
              home.packages = with pkgs;[
                exa
                starship
                neovim
                redis
              ];
            })
            ./modules/fish.nix
            ./modules/starship.nix
          ];
        };
      };
    };
}


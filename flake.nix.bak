{
  description = "Hanan Nix Configuration";
  inputs = {
    # change tag or commit of nixpkgs for your system
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # change main to a tag o git revision
    mk-darwin-system.url = "github:vic/mk-darwin-system/main";
    mk-darwin-system.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, mk-darwin-system, ... }:
    let
      darwinFlakeOutput = mk-darwin-system.mkDarwinSystem.m1 {
        # Provide your nix modules to enable configurations on your system.
        modules = [
          # You might want to split them into separate files
          #  ./modules/host-one-module.nix
          #  ./modules/user-one-module.nix
          #  ./modules/user-two-module.nix
          # Or you can inline them here, eg.

          # for configurable nix-darwin modules see
          # https://github.com/LnL7/nix-darwin/blob/master/modules/module-list.nix

          ({ config, pkgs, ... }: {
            environment.systemPackages = with pkgs; [ nixfmt ];
          })

          # An example of user environment. Change your username.
          ({ pkgs, lib, ... }: {
            users.users."hanan".home = "/Users/hanan";
            home-manager.useUserPackages = true;
            home-manager.users."hanan" = {
              home.packages = with pkgs; [
                exa
                starship
                neovim
                redis
              ];

              programs.fish.enable = true;
              programs.fish.plugins = with pkgs.fishPlugins; [
                {
                  name = "nix-env";
                  src = pkgs.fetchFromGitHub {
                    owner = "lilyball";
                    repo = "nix-env.fish";
                    rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
                    sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
                  };
                }
              ];

              programs.fish.shellInit = ''
                 eval "$(/opt/homebrew/bin/brew shellenv)"
                 zoxide init fish | source
                fish_add_path /opt/homebrew/opt/openjdk/bin
                 for p in /run/current-system/sw/bin ~/bin
                     if not contains $p $fish_user_paths
                         set -g fish_user_paths $p $fish_user_paths
                     end
                 end

                 # Config 
                 fish_vi_key_bindings
                 set -U fish_color_command 6CB6EB --bold
                 set -U fish_color_redirection DEB974
                 set -U fish_color_operator DEB974
                 set -U fish_color_end C071D8 --bold
                 set -U fish_color_error EC7279 --bold
                 set -U fish_color_param 6CB6EB
                 set fish_greeting

                 set PATH "/Users/hanan/.composer/vendor/bin" $PATH
                 set PATH "/Users/hanan/go/bin" $PATH
              '';

              programs.fish.shellAliases = {
                vim = "nvim";
                cat = "bat";
              };

              # Fish prompt and style
              programs.starship.enable = true;
              programs.starship.settings = {
                add_newline = true;
                command_timeout = 1000;
                cmd_duration = {
                  format = " [$duration]($style) ";
                  style = "bold #EC7279";
                  show_notifications = true;
                };
                nix_shell = {
                  format = " [$symbol$state]($style) ";
                };
                battery = {
                  full_symbol = "🔋 ";
                  charging_symbol = "⚡️ ";
                  discharging_symbol = "💀 ";
                };
                git_branch = {
                  format = "[$symbol$branch]($style) ";
                };
                gcloud = {
                  format = "[$symbol$active]($style) ";
                };
              };

              programs.git = {
                enable = true;
                userName = "hanan";
                userEmail = "hasyrawi@gmail.com";
              };
            };
          })

          # for configurable nixos modules see (note that many of them might be linux-only):
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/module-list.nix
          ({ config, lib, ... }: {
            services.redis = {
              enable = true;
              extraConfig = "--daemonize yes";
            };
          })
        ];
      };
    in
    darwinFlakeOutput
    // {
      # Your custom flake output here.
      darwinConfigurations."Hanans-MacBook-Air" = darwinFlakeOutput.darwinConfiguration.aarch64-darwin;
    };
}

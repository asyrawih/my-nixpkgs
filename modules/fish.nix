({ pkgs, config, lib, ... }:

  let
    mkAfter = lib.mkAfter;
    shellAliases = with pkgs;{
      gss = "git status";
      e = "nvim";
      vim = "nvim";
      cat = "bat";
      ls = "exa";
    };

  in
  {
    home = with pkgs; {
      sessionVariables = {
        RUST_SRC_PATH = "${rust.packages.stable.rustPlatform.rustLibSrc}";
      };
      packages = with fishPlugins;[
        thefuck
        # https://github.com/franciscolourenco/done
        done
        # use babelfish than foreign-env
        foreign-env
        # https://github.com/wfxr/forgit
        forgit
        # Paired symbols in the command line
        pisces
      ];
    };

    xdg.configFile."fish/conf.d/plugin-git-now.fish".text = mkAfter ''
      for f in $plugin_dir/*.fish
        source $f
      end
    '';

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
      {
        name = "thefuck";
        src = pkgs.fetchFromGitHub
          {
            owner = "oh-my-fish";
            repo = "plugin-thefuck";
            rev = "6c9a926d045dc404a11854a645917b368f78fc4d";
            sha256 = "1n6ibqcgsq1p8lblj334ym2qpdxwiyaahyybvpz93c8c9g4f9ipl";
          };
      }
      {
        name = "plugin-git";
        src = pkgs.fetchFromGitHub
          {
            owner = "jhillyerd";
            repo = "plugin-git";
            rev = "cc5999fa296c18105fb62f1637deec1d12454129";
            sha256 = "NaDZLmktuwlYxxzwDoVKgd8bEY+Wy9b2Qaz0CTf8V/Q=";
          };
      }
    ];

    programs.fish.shellInit = ''
      eval "$(/usr/local/bin/brew shellenv)"

      zoxide init fish | source

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

    '';

    programs.fish.shellAliases = shellAliases;
  })

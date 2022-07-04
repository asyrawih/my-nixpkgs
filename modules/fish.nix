({ pkgs, config, lib, ... }: {

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

})

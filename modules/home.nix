({ pkgs, lib, config, ... }: {

  programs.gpg = {
    enable = true;
    settings = {
      use-agent = true;
    };
  };

  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  home.stateVersion = "22.05";
  home.username = "hanan";
  home.homeDirectory = "/Users/indodax";
  home.packages = with pkgs;[
    coreutils
    curl
    wget
    tree
    gnupg # required for pass git
    ack
    exa
    starship
    neovim
    fzf
    fzy
    jq
    rust-analyzer
    rustc
    cargo
    rnix-lsp
    tmux
    yarn
    nodejs-16_x
    ffmpeg
    neofetch # fancy fetch information
    du-dust # fancy du
    imagemagick
    ack
    google-cloud-sdk
  ];
})

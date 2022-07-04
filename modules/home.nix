({ pkgs, lib, config, ... }: {
  home.stateVersion = "22.05";
  home.username = "hanan";
  home.homeDirectory = "/Users/hanan";
  home.packages = with pkgs;[
    exa
    starship
    neovim
    redis
    fzf
    fzy
    ripgrep
  ];
})

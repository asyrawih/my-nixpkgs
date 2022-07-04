({ pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "hanan";
    userEmail = "hasyrawi@gmail.com";
  };
})

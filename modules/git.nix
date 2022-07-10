({ pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "hanan";
    userEmail = "hasyrawi@gmail.com";
    signingKey = "7FBBBEAB02273DBD";
  };

  programs.git.extraConfig = {
    gpg.program = "gpg";
    rerere.enable = true;
    commit.gpgSign = true;
    pull.ff = "only";
    diff.tool = "vimdiff";
    difftool.prompt = false;
    merge.tool = "vimdiff";
  };
})

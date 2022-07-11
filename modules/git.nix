({ pkgs, lib, ... }:
  let

    hanan = {
      name = "hanan";
      email = "hasyrawi@gmail.com";
      signingKey = "7FBBBEAB02273DBD";
    };

  in
  {
    programs.git = {
      enable = true;
      userName = "asyrawih";
      userEmail = "hasyrawi@gmail.com";
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
    # Git Configuration By Folder So We Change Change Configuration per folder envirotment
    programs.git.includes = [
      {
        condition = "gitdir:~/projects/indodax/";
        contents.user = hanan;
      }
    ];

    ### git tools
    ## github cli
    programs.gh.enable = true;
    programs.gh.settings.git_protocol = "ssh";
    programs.gh.settings.aliases = {
      co = "pr checkout";
      pv = "pr view";
    };

  })
#signingKey = "7FBBBEAB02273DBD";


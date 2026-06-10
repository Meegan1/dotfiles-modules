{
  dotfiles-modules.google-chrome = {
    homeManager = {
      programs.google-chrome = {
        enable = true;

        extensions = [
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
          { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
        ];
      };
    };

  };
}

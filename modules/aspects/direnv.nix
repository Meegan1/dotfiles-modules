{
  dotfiles-modules.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;

        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}

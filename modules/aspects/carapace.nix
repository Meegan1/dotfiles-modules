{
  dotfiles-modules.carapace = {
    homeManager = {
      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}

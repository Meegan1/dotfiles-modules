{
  dotfiles-modules.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}

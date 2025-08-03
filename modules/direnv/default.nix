{
  homeModules.direnv = {
    programs.direnv = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}

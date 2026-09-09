{
  dotfiles-modules.bat = {
    homeManager = {
      programs.bat = {
        enable = true;
      };

      home.sessionVariables = {
        MANROFFOPT = "-c";
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      };
    };
  };
}

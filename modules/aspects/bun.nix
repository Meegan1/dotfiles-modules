{
  shared.bun = {
    homeManager =
      {
        config,
        ...
      }:
      {
        programs.bun = {
          enable = true;
        };

        home.sessionPath = [
          "${config.home.homeDirectory}/.bun/bin"
        ];
      };
  };
}

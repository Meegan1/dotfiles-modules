{
  shared.nodejs = {
    homeManager =
      {
        config,
        pkgs,
        ...
      }:
      {
        home.packages = [
          pkgs.nodejs_22
        ];

        home.sessionPath = [
          "${config.home.homeDirectory}/.npm-packages/bin"
        ];
      };
  };
}

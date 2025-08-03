{
  homeModules.lemonade =
    {
      pkgs,
      ...
    }:
    {
      home.file = {
        ".config/lemonade.toml" = {
          source = ./lemonade.toml;
        };
      };

      launchd.agents.lemonade = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.lemonade}/bin/lemonade"
            "server"
          ];
          KeepAlive = true;
          RunAtLoad = true;
        };
      };
    };
}

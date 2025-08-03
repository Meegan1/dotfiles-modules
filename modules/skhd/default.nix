{
  darwinModules.skhd = {
    services.skhd = {
      enable = true;
    };
  };

  homeModules.skhd =
    { config, ... }:
    {
      home.file = {
        ".config/skhd/skhdrc" = {
          source = ./config/skhdrc;
        };
      };
    };
}

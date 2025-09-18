{
  homeModules.skhd = {
    services.skhd = {
      enable = true;
    };
  };

  homeModules.yabai =
    { config, ... }:
    {
      services.skhd = {
        enable = true;
        config = ./config/yabai/skhdrc;
      };
    };

  homeModules.aerospace =
    { config, ... }:
    {
      services.skhd = {
        enable = true;
        config = ./config/aerospace/skhdrc;
      };
    };
}

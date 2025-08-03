{
  darwinModules.yabai = {
    services.yabai = {
      enable = true;
    };
  };

  homeModules.yabai =
    { config, ... }:
    {
      home.file = {
        ".config/yabai/yabairc" = {
          source = ./config/yabairc;
        };
      };
    };
}

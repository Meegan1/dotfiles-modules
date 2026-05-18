{
  shared.yabai = {
    darwin = {
      services.yabai = {
        enable = true;
      };
    };

    homeManager = {
      home.file = {
        ".config/yabai/yabairc" = {
          source = ./config/yabairc;
        };
      };
    };
  };
}

{
  shared.skhd = {
    homeManager = {
      services.skhd = {
        enable = true;
      };
    };

    provides.yabai.homeManager = {
      services.skhd = {
        enable = true;
        config = ./config/yabai/skhdrc;
      };
    };

    provides.aerospace.homeManager = {
      services.skhd = {
        enable = true;
        config = ./config/aerospace/skhdrc;
      };
    };
  };
}

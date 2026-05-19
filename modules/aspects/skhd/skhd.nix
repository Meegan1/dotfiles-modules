{
  dotfiles-modules.skhd = {
    homeManager = {
      services.skhd = {
        enable = true;
      };
    };

    provides.yabai.homeManager = {
      services.skhd = {
        config = ./config/yabai/skhdrc;
      };
    };

    provides.aerospace.homeManager = {
      services.skhd = {
        config = ./config/aerospace/skhdrc;
      };
    };
  };
}

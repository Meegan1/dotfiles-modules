{ dotfiles-modules, ... }:
{
  dotfiles-modules.skhd =
    { user, ... }:
    {
      homeManager =
        { lib, ... }:
        lib.mkMerge [
          {
            services.skhd.enable = true;
          }

          (lib.mkIf (user.hasAspect dotfiles-modules.yabai) {
            services.skhd.config = ./config/yabai/skhdrc;
          })

          (lib.mkIf (user.hasAspect dotfiles-modules.aerospace) {
            services.skhd.config = ./config/aerospace/skhdrc;
          })
        ];
    };
}

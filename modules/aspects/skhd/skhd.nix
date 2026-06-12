{ dotfiles-modules, ... }:
{
  dotfiles-modules.skhd =
    { user, ... }:
    {
      homeManager =
        { lib, pkgs, ... }:
        lib.mkMerge [
          {
            services.skhd.enable = true;
            services.skhd.package = pkgs.callPackage ./_package.nix { };
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

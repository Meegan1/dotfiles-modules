{
  darwinModules.sketchybar =
    {
      pkgs,
      ...
    }:
    {
      system.defaults.NSGlobalDomain._HIHideMenuBar = true;

      fonts.packages = [
        (pkgs.callPackage ./packages/sketchybar-app-font.nix { })
      ];
    };

  homeModules.sketchybar =
    { pkgs, config, ... }:
    {
      programs.sketchybar.enable = true;
      programs.sketchybar.config = {
        source = ./config;
        recursive = true;
      };
      programs.sketchybar.configType = "lua";

      home.file = {
        ".local/share/sketchybar_lua/sketchybar.so" = {
          source = "${
            (pkgs.callPackage ./packages/sbarlua.nix { }).outPath
          }/.local/share/sketchybar_lua/sketchybar.so";
          executable = true;
        };
      };
    };
}

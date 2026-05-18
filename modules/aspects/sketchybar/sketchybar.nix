{
  shared.sketchybar = {
    darwin =
      {
        pkgs,
        ...
      }:
      {
        system.defaults.NSGlobalDomain._HIHideMenuBar = true;

        fonts.packages = [
          (pkgs.callPackage ./_packages/sketchybar-app-font.nix { })
        ];
      };

    homeManager =
      { pkgs, ... }:
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
              (pkgs.callPackage ./_packages/sbarlua.nix { }).outPath
            }/.local/share/sketchybar_lua/sketchybar.so";
            executable = true;
          };
        };
      };
  };
}

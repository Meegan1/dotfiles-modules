{
  darwinModules.sketchybar =
    {
      pkgs,
      ...
    }:
    {
      system.defaults.NSGlobalDomain._HIHideMenuBar = true;

      environment.systemPackages = [
        (pkgs.callPackage ./packages/sbarlua.nix { })
      ];

      fonts.packages = [
        (pkgs.callPackage ./packages/sketchybar-app-font.nix { })
      ];

      services.sketchybar = {
        enable = true;
      };
    };

  homeModules.sketchybar =
    { pkgs, config, ... }:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
    in
    {
      home.file = {
        ".config/sketchybar" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/sketchybar/config";
        };
        ".local/share/sketchybar_lua/sketchybar.so" = {
          source = "${
            (pkgs.callPackage ./packages/sbarlua.nix { }).outPath
          }/.local/share/sketchybar_lua/sketchybar.so";
          executable = true;
        };
      };
    };
}

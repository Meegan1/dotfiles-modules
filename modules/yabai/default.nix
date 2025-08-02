{
  darwinModules.yabai = {
    services.yabai = {
      enable = true;
    };
  };

  homeModules.yabai =
    { config, ... }:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
    in
    {
      home.file = {
        ".config/yabai/yabairc" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix/darwin/modules/yabai/config/yabairc";
          # executable = true;
        };
      };
    };
}

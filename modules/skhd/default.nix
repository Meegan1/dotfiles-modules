{
  darwinModules.skhd = {
    services.skhd = {
      enable = true;
    };
  };

  homeModules.skhd =
    { config, ... }:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
    in
    {
      home.file = {
        ".config/skhd/skhdrc" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix/darwin/modules/skhd/config/skhdrc";
        };
      };
    };
}

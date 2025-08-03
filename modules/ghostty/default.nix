{
  hostModules.ghostty = { };

  nixosModules.ghostty =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        ghostty
      ];
    };

  darwinModules.ghostty = {
    homebrew = {
      casks = [
        "ghostty"
      ];
    };
  };

  homeModules.ghostty =
    { config, ... }:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
    in
    {

      home.file = {
        ".config/ghostty" = {
          source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/ghostty/config";
        };
      };
    };

}

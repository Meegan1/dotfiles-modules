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
    {

      home.file = {
        ".config/ghostty" = {
          source = ./config;
        };
      };
    };
}

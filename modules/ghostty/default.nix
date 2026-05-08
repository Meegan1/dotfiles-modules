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

  darwinModules.ghostty =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ghostty-bin
      ];
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

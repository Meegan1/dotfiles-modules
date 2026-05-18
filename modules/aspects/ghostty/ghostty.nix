{
  shared.ghostty = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          ghostty
        ];
      };

    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ghostty-bin
        ];
      };

    homeManager = {

      home.file = {
        ".config/ghostty" = {
          source = ./config;
        };
      };
    };
  };
}

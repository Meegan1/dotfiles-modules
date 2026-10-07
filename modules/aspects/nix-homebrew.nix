{
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    nix-homebrew.url = lib.mkDefault "github:zhaofengli-wip/nix-homebrew";
  };

  dotfiles-modules.nix-homebrew = {
    darwin =
      {
        config,
        ...
      }:
      {
        imports = [
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];

        # Homebrew
        nix-homebrew = {
          # Install Homebrew under the default prefix
          enable = true;
          # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
          enableRosetta = true;
          user = config.system.primaryUser;
        };

        homebrew = {
          enable = true;

          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };
      };

    homeManager = {
      home.sessionPath = [
        "/opt/homebrew/bin"
      ];
    };
  };
}

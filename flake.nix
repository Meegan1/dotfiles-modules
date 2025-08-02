{
  description = "Motion 12 Nix Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    inputs@{ flake-parts, home-manager, ... }:
    # https://flake.parts/module-arguments.html
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          home-manager.flakeModules.home-manager
          ./modules/darwin.nix
          ./modules/host-config.nix
        ];

        flake =
          { config, ... }:
          {
            # Import all ${dir}/default.nix in ./modules
            imports = builtins.map (dir: ./modules + "/${dir}") (
              builtins.filter (name: (builtins.readDir ./modules)."${name}" == "directory") (
                builtins.attrNames (builtins.readDir ./modules)
              )
            );

            hostModules.default = {
              imports = with config.hostModules; [
                ghostty
                podman
                rust
                tmate
              ];
            };

            darwinModules.default = {
              imports = with config.darwinModules; [
                capslock-delay
                touch-id
              ];
            };

            homeModules.default = {
              imports = with config.homeModules; [
                devenv
                ghostty
              ];
            };
          };

        systems = [
          # systems for which you want to build the `perSystem` attributes
          "x86_64-linux"
          "aarch64-darwin"
        ];
        perSystem =
          {
            config,
            pkgs,
            system,
            ...
          }:
          {
            # Recommended: move all package definitions here.
            # e.g. (assuming you have a nixpkgs input)
            # packages.foo = pkgs.callPackage ./foo/package.nix { };
            # packages.bar = pkgs.callPackage ./bar/package.nix {
            #   foo = config.packages.foo;
            # };
          };
      }
    );
}

{
  description = "Motion 12 Nix Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      flake-parts,
      home-manager,
      nix-homebrew,
      ...
    }:
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
          ./modules/legacy.nix
        ];

        flake =
          { config, ... }:
          let
            moduleArgs = {
              inherit inputs moduleWithSystem;
            };

            importModule =
              dir:
              let
                mod = import (./modules + "/${dir}");
              in
              if builtins.isFunction mod then mod moduleArgs else mod;
          in
          {
            # Import all ${dir}/default.nix in ./modules
            imports = map importModule (
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
                nix-homebrew.darwinModules.nix-homebrew
                home-manager.darwinModules.home-manager
                legacy
                capslock-delay
                touch-id
                pf-redirect
                ghostty
              ];
            };

            nixosModules.default = {
              imports = with config.nixosModules; [
                ghostty
              ];
            };

            homeModules.default = {
              imports = with config.homeModules; [
                legacy
                devenv
                ghostty
                ast-grep
                bash
                btop
                bun
                carapace
                codesnap
                devpod
                direnv
                fzf
                git
                lemonade
                nodejs
                starship
                tldr
                tmux
                zoxide
                zsh
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

{ lib, config, ... }:
let
  inherit (lib)
    types
    recursiveUpdate
    ;
in
{
  options.hostConfigurations = lib.mkOption {
    type = types.lazyAttrsOf types.raw;
    default = { };
    description = "Instantiated NixOS and Darwin configurations. Used by `nixos-rebuild`.";
  };

  options.hostModules = lib.mkOption {
    type = types.lazyAttrsOf types.raw;
    default = { };
    description = "Instantiated NixOS and Darwin modules. Used by `nixos-rebuild`.";
  };

  config = {
    nixosConfigurations = recursiveUpdate {
      # This is a workaround to avoid the `nixosConfigurations` being empty.
      # It will be populated by the `hostConfigurations` option.
      default = { };
    } config.hostConfigurations;

    nixosModules = recursiveUpdate {
      # This is a workaround to avoid the `nixosModules` being empty.
      # It will be populated by the `hostModules` option.
      default = { };
    } config.hostModules;

    darwinConfigurations = recursiveUpdate {
      # This is a workaround to avoid the `darwinConfigurations` being empty.
      # It will be populated by the `hostConfigurations` option.
      default = { };
    } config.hostConfigurations;

    darwinModules = recursiveUpdate {
      # This is a workaround to avoid the `darwinModules` being empty.
      # It will be populated by the `hostModules` option.
      default = { };
    } config.hostModules;
  };
}

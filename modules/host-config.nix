{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    types
    literalExpression
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
    nixosConfigurations = config.hostConfigurations // {
      # This is a workaround to avoid the `nixosConfigurations` being empty.
      # It will be populated by the `hostConfigurations` option.
      default = { };
    };
    nixosModules = config.hostModules // {
      # This is a workaround to avoid the `nixosModules` being empty.
      # It will be populated by the `hostModules` option.
      default = { };
    };

    darwinConfigurations = config.hostConfigurations // {
      # This is a workaround to avoid the `darwinConfigurations` being empty.
      # It will be populated by the `hostConfigurations` option.
      default = { };
    };
    darwinModules = config.hostModules // {
      # This is a workaround to avoid the `darwinModules` being empty.
      # It will be populated by the `hostModules` option.
      default = { };
    };
  };
}

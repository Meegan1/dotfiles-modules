{
  description = "Motion 12 Nix Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nix-darwin,
      ...
    }:
    {
      darwinConfigurations.darwin = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/darwin/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}

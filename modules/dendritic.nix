{ lib, ... }:
{
  flake-file.inputs = {
    den.url = lib.mkDefault "github:denful/den";
    flake-file.url = lib.mkDefault "github:denful/flake-file";
    home-manager = {
      url = lib.mkDefault "github:nix-community/home-manager";
      inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
    };
  };
}

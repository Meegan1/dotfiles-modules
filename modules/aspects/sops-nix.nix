{ inputs, lib, ... }:
{
  flake-file.inputs.sops-nix.url = lib.mkDefault "github:Mic92/sops-nix";
  flake-file.inputs.sops-nix.inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";

  dotfiles-modules.sops-nix = {
    nixos =
      if inputs ? sops-nix then
        {
          imports = [
            inputs.sops-nix.nixosModules.sops
          ];
        }
      else
        throw "den: sops-nix aspect requires inputs.sops-nix in your flake";

    darwin =
      if inputs ? sops-nix then
        {
          imports = [
            inputs.sops-nix.darwinModules.sops
          ];
        }
      else
        throw "den: sops-nix aspect requires inputs.sops-nix in your flake";
  };
}

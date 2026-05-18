{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs.dotfiles-modules.url = lib.mkDefault "github:meegan1/dotfiles-modules";
  imports = [
    (inputs.den.namespace "dotfiles-modules" [
      inputs.dotfiles-modules
    ])
  ];

  den.default.includes = [
    den.batteries.inputs'
  ];
}

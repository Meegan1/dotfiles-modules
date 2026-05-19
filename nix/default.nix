{ inputs, ... }:
inputs.flake-parts.lib.mkFlake { inherit inputs; } {
  imports = [
    (inputs.import-tree ../modules)

    {
      imports = [
        (inputs.flake-file.flakeModules.dendritic or { })
        (inputs.den.flakeModules.dendritic or { })
      ];

      flake.flakeModule = import ./flakeModule.nix;
      flake.flakeModules.dendritic = import ./dendritic.nix;
    }
  ];
}

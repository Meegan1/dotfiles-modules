{
  lib,
  ...
}:
{
  flake-file.inputs.dotfiles-modules.url = lib.mkDefault "github:meegan1/dotfiles-modules";
}

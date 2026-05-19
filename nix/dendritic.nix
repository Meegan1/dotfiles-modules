{ inputs, lib, ... }:
{
  flake-file.inputs.dotfiles-modules.url = lib.mkDefault "github:meegan1/dotfiles-modules";
  imports = [ (inputs.dotfiles-modules.flakeModule or { }) ];
}

{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "dotfiles-modules" false)
  ];
}

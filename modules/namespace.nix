{ inputs, config, ... }:
{
  imports = [
    (inputs.den.namespace "shared" false)
  ];

  config.flake.denful.dotfiles-modules = config.den.ful.shared;
}

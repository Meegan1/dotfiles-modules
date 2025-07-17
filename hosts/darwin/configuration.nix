{ config, inputs, ... }:
{
  imports = [
    ../../modules/devenv
  ];

  nixpkgs.hostPlatform = inputs.nixpkgs.system;
  system.primaryUser = "motion12";
}

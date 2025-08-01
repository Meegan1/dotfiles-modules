{ pkgs, ... }:
{
  hostConfigurations.default.environment.systemPackages = with pkgs; [
    devenv
  ];
}

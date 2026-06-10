{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "25.11";
  den.default.homeManager.home.stateVersion = "25.11";
  den.default.darwin.system.stateVersion = 6;

  den.default.includes = [
    den.batteries.inputs'
    den.batteries.define-user
  ];

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}

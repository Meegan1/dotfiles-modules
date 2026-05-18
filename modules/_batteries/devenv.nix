{
  inputs,
  ...
}:
let
  description = ''
    Enable Determinate Nix on NixOS hosts.
  '';

  determinate = {
    name = "determinate-nix";
    description = description;

    darwin =
      if inputs ? determinate then
        {
          imports = [ inputs.determinate.darwinModules.default ];

          determinateNix.enable = true;
        }
      else
        throw "den: determinate-nix battery requires inputs.determinate in your flake";
  };
in
{
  den.batteries.determinate = determinate;
}

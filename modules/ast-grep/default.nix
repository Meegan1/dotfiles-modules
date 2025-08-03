{
  homeModules.ast-grep =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        ast-grep
      ];
    };
}

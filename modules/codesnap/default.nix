{
  homeModules.codesnap =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        codesnap
      ];
    };
}

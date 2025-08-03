{
  homeModules.tldr =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        tlrc
      ];
    };
}

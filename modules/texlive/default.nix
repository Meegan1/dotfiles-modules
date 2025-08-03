{
  homeModules.texlive =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        texlive.combined.scheme-full
      ];
    };
}

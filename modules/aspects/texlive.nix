{
  dotfiles-modules.texlive = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          texlive.combined.scheme-full
        ];
      };
  };
}

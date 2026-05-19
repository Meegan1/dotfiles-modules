{
  dotfiles-modules.codesnap = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          codesnap
        ];
      };
  };
}

{
  dotfiles-modules.localsend = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          localsend
        ];
      };
  };
}

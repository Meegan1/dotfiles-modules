{
  dotfiles-modules.ast-grep = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          ast-grep
        ];
      };
  };
}

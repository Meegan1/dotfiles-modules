{
  dotfiles-modules.ollama = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          ollama
        ];
      };
  };
}

{
  dotfiles-modules.tldr = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          tlrc
        ];
      };
  };
}

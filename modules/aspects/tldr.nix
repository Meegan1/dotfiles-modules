{
  shared.tldr = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          tlrc
        ];
      };
  };
}

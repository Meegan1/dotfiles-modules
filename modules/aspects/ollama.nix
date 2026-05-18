{
  shared.ollama = {
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

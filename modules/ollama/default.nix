{
  homeModules.ollama =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        ollama
      ];
    };
}

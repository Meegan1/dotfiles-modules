{
  hostModules.tmate =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        tmate
      ];
    };
}

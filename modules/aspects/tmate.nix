{
  shared.tmate = {
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
  };
}

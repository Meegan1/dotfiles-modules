{
  hostModules.podman =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        podman
        podman-compose
      ];
    };

  darwinModules.podman =
    { pkgs, ... }:
    {
      # Forward ports from 80 to 8080 and from 443 to 8443
      # for rootless podman containers
      services.pfRedirect = {
        enable = false;
        rules = [
          {
            interface = "lo0";
            fromPort = 80;
            toPort = 8080;
          }
          {
            interface = "en0";
            fromPort = 80;
            toPort = 8080;
          }
          {
            interface = "lo0";
            fromPort = 443;
            toPort = 8443;
          }
          {
            interface = "en0";
            fromPort = 443;
            toPort = 8443;
          }
        ];
      };
    };
}

{
  darwinModules.pf-redirect =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    with lib;

    let
      cfg = config.services.pfRedirect;
      pfConf = pkgs.writeText "pf-redirect.conf" (
        concatStringsSep "\n" (
          map (
            rule:
            "rdr pass on ${rule.interface} inet proto tcp from any to any port ${toString rule.fromPort} -> 127.0.0.1 port ${toString rule.toPort}"
          ) cfg.rules
        )
        + "\n"
      );
    in
    {
      options.services.pfRedirect = {
        enable = mkEnableOption "Enable pf port redirects";
        rules = mkOption {
          type = types.listOf (
            types.submodule {
              options = {
                interface = mkOption {
                  type = types.str;
                  description = "Network interface";
                };
                fromPort = mkOption {
                  type = types.port;
                  description = "Source port";
                };
                toPort = mkOption {
                  type = types.port;
                  description = "Destination port";
                };
              };
            }
          );
          default = [ ];
          description = "List of port redirect rules";
        };
      };

      config = mkIf cfg.enable {
        launchd.daemons.pf-redirect = {
          script = ''
            exec >> /tmp/pf-redirect.log 2>&1
            /sbin/pfctl -f ${pfConf}
            /sbin/pfctl -e
          '';
          serviceConfig.RunAtLoad = true;
          serviceConfig.KeepAlive = true;
        };
      };
    };
}

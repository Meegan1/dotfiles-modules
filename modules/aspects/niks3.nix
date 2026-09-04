{
  inputs,
  lib,
  dotfiles-modules,
  ...
}:
{
  flake-file.inputs.niks3.url = lib.mkDefault "github:mic92/niks3";

  dotfiles-modules.niks3 = {
    homeManager =
      {
        pkgs,
        osConfig,
        config,
        ...
      }:
      if inputs ? niks3 then
        let
          hasNiks3Token =
            osConfig ? sops && osConfig.sops ? secrets && osConfig.sops.secrets ? "niks3-auth-token";

          tokenSecret =
            if hasNiks3Token then
              osConfig.sops.secrets."niks3-auth-token"
            else
              throw ''den: niks3 aspect requires sops.secrets."niks3-auth-token" to be configured by the host'';

          hasNiks3Settings = osConfig ? niks3 && osConfig.niks3 ? serverUrl;

          serverUrl =
            if hasNiks3Settings then
              osConfig.niks3.serverUrl
            else
              throw "den: niks3 aspect requires niks3.serverUrl to be configured by the host";
        in
        {
          home.packages = [
            inputs.niks3.packages.${pkgs.stdenv.hostPlatform.system}.niks3
          ];

          home.sessionVariables = {
            NIKS3_SERVER_URL = serverUrl;
          };

          # Symlink the host-provided sops secret to where niks3 expects it.
          xdg.configFile."niks3/auth-token".source = config.lib.file.mkOutOfStoreSymlink tokenSecret.path;
        }
      else
        throw "den: niks3 aspect requires inputs.niks3 in your flake";

    os =
      { host, config, ... }:
      {
        options.niks3 = {
          serverUrl = lib.mkOption {
            type = lib.types.str;
            description = "NIKS3 server URL.";
          };

          substituters = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Substituters for the niks3 binary cache.";
          };

          trustedPublicKeys = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Trusted public keys for the niks3 binary cache.";
          };
        };

        config = {
          nix.settings = {
            substituters = config.niks3.substituters;
            trusted-public-keys = config.niks3.trustedPublicKeys;
          };

          determinateNix = (
            lib.mkIf (host.hasAspect dotfiles-modules.determinate) {
              customSettings = {
                extra-substituters = config.niks3.substituters;
                extra-trusted-public-keys = config.niks3.trustedPublicKeys;
              };
            }
          );
        };
      };
  };
}

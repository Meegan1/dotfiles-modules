{
  homeModules.devenv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        devenv
      ];

      home.file = {
        ".config/process-compose/theme.yaml" = {
          source =
            pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "process-compose";
              rev = "main"; # Pin to a specific commit for reproducibility
              hash = "sha256-uqJR9OPrlbFVnWvI3vR8iZZyPSD3heI3Eky4aFdT0Qo=";
            }
            + "/themes/catppuccin-mocha.yaml";
        };
        ".config/process-compose/settings.yaml" = {
          text = ''
            theme: Custom Style
          '';
        };
      };
    };
}

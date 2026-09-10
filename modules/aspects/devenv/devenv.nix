{ inputs, lib, ... }:
{

  flake-file.inputs = {
    devenv.url = lib.mkDefault "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  dotfiles-modules.devenv = {
    homeManager =
      { pkgs, ... }: # home-manager module args
      {
        home.packages = [
          inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

        xdg.configFile = {
          "devenv/config.yaml".text = lib.generators.toYAML { } {
            version = 1;
            shell.prompt_prefix = false;
            tui.statusline.enabled = false;
          };

          "process-compose/theme.yaml".source =
            (pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "process-compose";
              rev = "b0c48aa07244a8ed6a7d339a9b9265a3b561464d"; # Pin to a specific commit for reproducibility
              hash = "sha256-uqJR9OPrlbFVnWvI3vR8iZZyPSD3heI3Eky4aFdT0Qo=";
            })
            + "/themes/catppuccin-mocha.yaml";

          "process-compose/settings.yaml".text = ''
            theme: Custom Style
          '';
        };

        programs.zsh.initContent = ''
          eval "$(devenv hook zsh)"
        '';
      };
  };
}

{
  dotfiles-modules.k9s = {
    homeManager =
      { pkgs, ... }:
      let
        catppuccinTheme = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/k9s/fdbec82284744a1fc2eb3e2d24cb92ef87ffb8b4/dist/catppuccin-mocha-transparent.yaml";
          hash = "sha256-ZPf7GVnbVOOsoB/wVevxFDwPayk2xKfMul8HXQVGUeE=";
        };
      in
      {
        programs.k9s = {
          enable = true;
          settings = {
            k9s = {
              ui.skin = "catppuccin-mocha";
            };
          };
          skins.catppuccin-mocha = catppuccinTheme;
        };
      };
  };
}

{ dotfiles-modules, ... }:
{
  dotfiles-modules.opencode = {
    includes = [
      dotfiles-modules.playwright-cli
    ];

    homeManager = {
      programs.opencode = {
        enable = true;
      };
    };
  };
}

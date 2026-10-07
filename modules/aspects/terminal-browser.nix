{
  dotfiles-modules,
  ...
}:
{

  dotfiles-modules.terminal-browser = {
    includes = [
      dotfiles-modules.nix-homebrew
    ];

    darwin = {
      homebrew = {
        casks = [
          "terminal-browser"
        ];
      };
    };
  };
}

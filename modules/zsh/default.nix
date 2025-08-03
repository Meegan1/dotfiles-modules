{
  homeModules.zsh =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";
        shellAliases = {
          nix = "noglob nix";
          switch = "noglob sudo darwin-rebuild switch --flake ~/dotfiles#macbook";
          garbage-collect = "noglob nix-collect-garbage -d";
          update = "noglob nix flake update --flake ~/dotfiles";
        };
        enableCompletion = false;
        antidote = {
          enable = true;
          plugins = [
            "zsh-users/zsh-syntax-highlighting"
            "zsh-users/zsh-autosuggestions"

            "ohmyzsh/ohmyzsh path:lib"
            "ohmyzsh/ohmyzsh path:plugins/git"
            "ohmyzsh/ohmyzsh path:plugins/pip"
            "ohmyzsh/ohmyzsh path:plugins/command-not-found"
            "ohmyzsh/ohmyzsh path:plugins/kubectl"
            "ohmyzsh/ohmyzsh path:plugins/colorize"
            "belak/zsh-utils path:completion"
          ];
        };
      };
    };
}

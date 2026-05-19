{
  dotfiles-modules.zsh = {
    homeManager =
      {
        config,
        lib,
        ...
      }:
      {
        programs.zsh = {
          enable = true;
          dotDir = "${config.home.homeDirectory}/.config/zsh";
          shellAliases = {
            nix = "noglob nix";
            switch = lib.mkDefault "noglob sudo darwin-rebuild switch --flake ~/dotfiles#macos";
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

          # bind Ctrl+Y to accept the autosuggestion
          initContent = ''
            # accept the current zsh-autosuggestions suggestion with Ctrl+Y
            bindkey '^Y' autosuggest-accept

            autoload -U history-search-end
            zle -N history-beginning-search-backward-end history-search-end
            zle -N history-beginning-search-forward-end history-search-end

            # jump to previous history entry that begins with the current buffer (Ctrl+P)
            bindkey '^P' history-beginning-search-backward-end
            bindkey '^N' history-beginning-search-forward-end

            # clear autosuggestion when using history search
            ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)
          '';
        };
      };
  };
}

{ dotfiles-modules, ... }:
{
  dotfiles-modules.default = {
    includes = [
      dotfiles-modules.ghostty
      dotfiles-modules.podman
      dotfiles-modules.tmate
      dotfiles-modules.legacy
      dotfiles-modules.capslock-delay
      dotfiles-modules.touch-id
      dotfiles-modules.pf-redirect
      dotfiles-modules.ast-grep
      dotfiles-modules.bash
      dotfiles-modules.btop
      dotfiles-modules.bun
      dotfiles-modules.carapace
      dotfiles-modules.codesnap
      dotfiles-modules.devenv
      dotfiles-modules.devpod
      dotfiles-modules.direnv
      dotfiles-modules.fzf
      dotfiles-modules.git
      dotfiles-modules.lemonade
      dotfiles-modules.nodejs
      dotfiles-modules.starship
      dotfiles-modules.tldr
      dotfiles-modules.tmux
      dotfiles-modules.zoxide
      dotfiles-modules.zsh
    ];
  };
}

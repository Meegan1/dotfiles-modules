{ shared, ... }:
{
  shared.default = {
    includes = [
      shared.ghostty
      shared.podman
      shared.rust
      shared.tmate
      shared.legacy
      shared.capslock-delay
      shared.touch-id
      shared.pf-redirect
      shared.ast-grep
      shared.bash
      shared.btop
      shared.bun
      shared.carapace
      shared.codesnap
      shared.devenv
      shared.devpod
      shared.direnv
      shared.fzf
      shared.git
      shared.lemonade
      shared.nodejs
      shared.starship
      shared.tldr
      shared.tmux
      shared.zoxide
      shared.zsh
    ];
  };
}

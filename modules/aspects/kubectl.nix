{
  dotfiles-modules.kubectl = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          kubeaudit
          kubectl
          kubectl-cnpg
          kustomize
        ];
      };
  };
}

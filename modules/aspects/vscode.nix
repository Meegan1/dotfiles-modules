{
  dotfiles-modules.vscode = {
    hostModules.vscode =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          vscode
        ];
      };
  };
}

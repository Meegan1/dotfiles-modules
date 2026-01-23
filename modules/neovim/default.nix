{
  homeModules.neovim =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        neovim
        neovim-remote
        tree-sitter
      ];
    };
}

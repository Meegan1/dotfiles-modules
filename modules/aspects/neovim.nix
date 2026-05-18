{
  shared.neovim = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          neovim
          neovim-remote
          tree-sitter
        ];
      };
  };
}

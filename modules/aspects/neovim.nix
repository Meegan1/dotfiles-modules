{ inputs, lib, ... }:
{
  flake-file.inputs.nvim-flake.url = lib.mkDefault "github:meegan1/nvim-flake";

  dotfiles-modules.neovim = {
    homeManager =
      if inputs ? nvim-flake then
        {
          imports = [
            inputs.nvim-flake.homeModules.default
          ];

          nvim.enable = true;
        }
      else
        throw "den: neovim aspect requires inputs.nvim-flake in your flake";
  };
}

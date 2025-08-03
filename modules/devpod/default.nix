{
  homeModules.devpod =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        (writeShellApplication {
          name = "nvim-devpod";

          runtimeInputs = [
            devpod
          ];

          text = builtins.readFile ./scripts/nvim-devpod.sh;
        })
        (writeShellApplication {
          name = "nvim-devcontainer-json";

          runtimeInputs = [
            jq
          ];

          text = builtins.readFile ./scripts/nvim-devcontainer-json.sh;
        })
      ];
    };
}

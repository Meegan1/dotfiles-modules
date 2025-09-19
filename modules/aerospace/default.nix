{
  homeModules.aerospace =
    { config, pkgs, ... }:
    {
      programs.aerospace.enable = true;

      programs.aerospace.userSettings = {
        gaps = {
          inner.horizontal = 8;
          inner.vertical = 8;

          outer.top = [
            { monitor."^built-in retina display$" = 5; }
            45
          ];
          outer.bottom = 10;
          outer.left = 5;
          outer.right = 5;
        };
        on-window-detected = [
          {
            "if" = {
              app-id = "app.zen-browser.zen";
              window-title-regex-substring = "Picture-in-Picture";
            };

            run = [
              "layout floating"
            ];
          }
        ];

        after-startup-command = [
          "exec-and-forget sketchybar"
          "exec-and-forget skhd"
        ];

        exec-on-workspace-change = [
          "/bin/bash"
          "-c"
          "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        ];
      };
    };
}

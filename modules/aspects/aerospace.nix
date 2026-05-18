{
  shared.aerospace = {
    homeManager = {
      programs.aerospace.enable = true;

      programs.aerospace.settings = {
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
          "exec-and-forget skhd"
        ];

        on-focus-changed = [
          "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
        ];

        exec-on-workspace-change = [
          "/bin/zsh"
          "-c"
          "/usr/bin/osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
        ];
      };
    };
  };
}

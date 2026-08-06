{
  dotfiles-modules.newsboat = {
    homeManager =
      { pkgs, ... }:
      let
        catppuccinTheme = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/newsboat/be3d0ee1ba0fc26baf7a47c2aa7032b7541deb0f/themes/dark";
          hash = "sha256-KZ3PQkgF5Q8deYfVsbFBfPQvihwHKZPR/qjRSs4DpSc=";
        };
      in
      {
        programs.newsboat = {
          enable = true;
          extraConfig = ''
            # Load the Catppuccin theme
            include "${catppuccinTheme}"

            # Vim-style navigation
            unbind-key j
            unbind-key k
            unbind-key l
            unbind-key h
            unbind-key J
            unbind-key K

            bind-key j down
            bind-key k up
            bind-key l open
            bind-key ESC quit
            bind-key J next-feed
            bind-key K prev-feed

            bind-key g home
            bind-key G end

            bind-key ^U halfpageup
            bind-key ^D halfpagedown
            bind-key ^F pagedown
            bind-key ^B pageup

            # Marking / reload
            bind-key n next-unread
            bind-key N prev-unread
            bind-key r reload
            bind-key R reload-all
            bind-key A mark-feed-read
            bind-key c mark-all-feeds-read
          '';
        };
      };
  };
}

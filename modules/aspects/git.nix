{
  dotfiles-modules.git = {
    homeManager = { pkgs, lib, ... }: {
      programs.git = {
        enable = true;
      };

      home.packages = with pkgs; [
        git-wt
      ];

      programs.zsh.initContent = (
        lib.mkAfter ''
          eval "$(git wt --init zsh)"
        ''
      );
    };
  };
}

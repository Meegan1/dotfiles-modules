{
  dotfiles-modules.element = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          (
            if stdenv.hostPlatform.isLinux then
              element-desktop.overrideAttrs (old: {
                nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ makeWrapper ];
                postInstall = (old.postInstall or "") + ''
                  wrapProgram $out/bin/element-desktop \
                    --add-flags "--password-store=gnome-libsecret"
                '';
              })
            else
              element-desktop
          )
        ];
      };
  };
}

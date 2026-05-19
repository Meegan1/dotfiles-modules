{
  dotfiles-modules.yubikey = {
    # https://github.com/gshpychka/dotfiles/blob/main/machines/eve/touch-id.nix
    darwin =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      with lib;
      let
        cfg = config.security.pam;
      in
      {
        options = {
          security.pam.enableSudoYubikey = mkEnableOption ''
            Enable sudo authentication with a YubiKey (pam_u2f).

            Create ~/.config/Yubico/u2f_keys using pamu2fcfg.

          '';
        };

        config = lib.mkIf (cfg.enableSudoYubikey) {
          environment.systemPackages = [ pkgs.pam_u2f ];
          environment.etc."pam.d/sudo_local".text = lib.mkOrder 500 ''
            # YubiKey U2F for sudo (user mapping file)
            # "cue" prints a prompt; "nouserok" allows users without u2f_keys to fall back to password
            auth       sufficient     ${pkgs.pam_u2f}/lib/security/pam_u2f.so authfile=.config/Yubico/u2f_keys cue nouserok
          '';
        };
      };
  };
}

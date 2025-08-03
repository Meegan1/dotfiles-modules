# A module for configurations/modules not yet migrated to the new module system.
{ self, ... }:
{
  flake = {
    darwinModules.legacy =
      {
        pkgs,
        config,
        ...
      }:
      {
        # Allow unfree packages.
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.mkalias
          pkgs.nixfmt-rfc-style

          pkgs.nixd

          (pkgs.callPackage ../packages/gwctl.nix { })

          pkgs._1password-cli
          pkgs.age
          pkgs.awscli
          pkgs.awsebcli
          pkgs.antidote
          pkgs.argocd
          pkgs.autoconf
          pkgs.automake
          pkgs.civo
          pkgs.cilium-cli
          pkgs.cmake
          pkgs.devcontainer
          pkgs.devpod
          pkgs.gh
          pkgs.bat
          pkgs.php83Packages.composer
          pkgs.curl
          pkgs.doctl
          pkgs.fd
          pkgs.ffmpeg
          pkgs.fluxcd
          pkgs.delta
          pkgs.git-filter-repo
          pkgs.glib
          pkgs.gnupg
          pkgs.gnutls
          pkgs.go
          pkgs.google-cloud-sdk
          pkgs.kubernetes-helm
          pkgs.helmfile
          pkgs.hubble
          pkgs.imagemagick.dev
          pkgs.jq
          pkgs.k9s
          pkgs.kind
          pkgs.kubeaudit
          pkgs.kubectl
          pkgs.kustomize
          pkgs.lazygit
          pkgs.lemonade
          pkgs.libevent
          pkgs.lua5_4
          pkgs.monaspace
          pkgs.mysql-client
          pkgs.neovim
          pkgs.neovim-remote
          pkgs.ngrok
          pkgs.ninja
          pkgs.nmap
          pkgs.fnm
          pkgs.openjdk
          pkgs.php
          pkgs.pkg-config
          pkgs.postgresql
          # pkgs.pulumi
          pkgs.pv
          pkgs.python3
          pkgs.rclone
          pkgs.ripgrep
          pkgs.s3cmd
          pkgs.semantic-release
          pkgs.shopify-cli
          pkgs.sops
          pkgs.tree
          pkgs.utf8proc
          pkgs.uv
          pkgs.vcluster
          pkgs.velero
          pkgs.watch
          pkgs.wget
          pkgs.xmake
          pkgs.yq
        ];

        system.defaults = {
          NSGlobalDomain = {
            KeyRepeat = 2;
            InitialKeyRepeat = 15;
            ApplePressAndHoldEnabled = false;
          };
        };

        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users.${config.system.primaryUser} = {
          name = config.system.primaryUser;
          home = "/Users/${config.system.primaryUser}";
          shell = pkgs.zsh;
        };

        nix.settings.trusted-users = [
          "root"
          "${config.system.primaryUser}"
        ];

        security.pam.enableSudoTouchId = true;

        environment.variables.EDITOR = "nvim";

        # Home Manager
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${config.system.primaryUser} = {
            home = {
              username = config.system.primaryUser;
              homeDirectory = "/Users/${config.system.primaryUser}";
              stateVersion = "24.05";
            };
          };
        };

        # Homebrew
        nix-homebrew = {
          # Install Homebrew under the default prefix
          enable = true;
          # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
          enableRosetta = true;
          user = config.system.primaryUser;
        };

        homebrew = {
          enable = true;
          casks = [
            "devpod"
            "linearmouse"
            "orbstack"
            "syntax-highlight"
            "font-monaspace"
            "sioyek"
          ];

          # Declarative tap management
          taps = [ ];

          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };
      };
  };
}

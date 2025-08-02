{
  hostModules.rust =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (import "${
          fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/main.tar.gz";
            sha256 = "0wfa9qlhm7shxdkhxcwy5w8fl10x5s733m3l1h5r6f2kmsyi94fh";
          }
        }/overlay.nix")
      ];
      environment.systemPackages = with pkgs; [
        (fenix.complete.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
        rust-analyzer-nightly
      ];
    };
}

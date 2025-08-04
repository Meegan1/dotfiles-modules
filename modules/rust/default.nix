{
  hostModules.rust =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (import "${
          fetchTarball {
            url = "https://github.com/nix-community/fenix/archive/f53ddf7518d85d59b58df6e9955b25b0ac25f569.zip";
            sha256 = "0zd51sqp5kz2kx6cyvfd9by3cwnslc7ny4jfp3ys6bjyy7bjc1ib";
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

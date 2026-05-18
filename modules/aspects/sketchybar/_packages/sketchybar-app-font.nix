{
  stdenv,
  fetchurl,
  lib,
}:
stdenv.mkDerivation {

  name = "sketchybar-app-font";
  src = fetchurl {
    url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.32/sketchybar-app-font.ttf";
    hash = "sha256-YRk2A2i7mGK4n1NB2c62ES7muBpQwzajDGQWf3f5RCw=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts
    cp $src $out/share/fonts/sketchybar-app-font.ttf
  '';

  meta = with lib; {
    description = "Sketchybar app font";
    homepage = "";
    license = licenses.isc;
    platforms = platforms.unix;
  };
}

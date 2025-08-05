{
  stdenv,
  fetchFromGitHub,
  lib,
  gcc,
  readline,
}:
stdenv.mkDerivation {

  name = "sbarlua";
  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "SbarLua";
    rev = "437bd2031da38ccda75827cb7548e7baa4aa9978";
    sha256 = "sha256-F0UfNxHM389GhiPQ6/GFbeKQq5EvpiqQdvyf7ygzkPg=";
  };

  nativeBuildInputs = [
    gcc
    readline
  ];

  installPhase = ''
    mkdir -p $out/.local/share/sketchybar_lua
    export HOME=$out
    make install
  '';

  meta = with lib; {
    description = "A lua plugin for sketchybar";
    homepage = "";
    license = licenses.isc;
    platforms = platforms.unix;
  };
}

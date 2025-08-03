{
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  libtool,
  pkg-config,
  libevent,
  ncurses,
  lib,
  utf8proc,
  bison,
}:
stdenv.mkDerivation {

  name = "tmux";
  src = fetchFromGitHub {
    owner = "jixiuf";
    repo = "tmux";
    rev = "a706656d3dc41fcc463d8b3fbdcaef25ab1e3b9a";
    sha256 = "sha256-+c39VvACj8O6MB4wESrGLu9V1Pwiy3P3Ln9f4YhOb7k=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    utf8proc
    bison
  ];

  buildInputs = [
    libevent
    ncurses
  ];

  configurePhase = ''
    ./autogen.sh
  '';

  buildPhase = ''
    ./configure \
      --prefix=$out \
      --enable-utf8proc 
    make
  '';

  meta = with lib; {
    description = "A terminal multiplexer";
    homepage = "https://tmux.github.io/";
    license = licenses.isc;
    platforms = platforms.unix;
  };
}

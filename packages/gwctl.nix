{
  lib,
  stdenv,
  fetchFromGitHub,
  go,
  git,
}:

stdenv.mkDerivation {
  name = "gwctl";

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = "gwctl";
    rev = "main"; # You might want to pin to a specific version/commit
    sha256 = "sha256-8xH3CJ2KI2bMmIEpGpxhsw0fxoTZ4vqu6+WQS8/SYuY="; # Add SHA after first attempt to build
  };

  nativeBuildInputs = [
    go
    git
  ];

  buildPhase = ''
    export GOPATH=$TMPDIR/go
    export GOCACHE=$TMPDIR/go-cache
    export GOMODCACHE=$TMPDIR/go-mod-cache
    export GO111MODULE=on

    # Create cache directories
    mkdir -p $GOCACHE
    mkdir -p $GOMODCACHE

    make build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/gwctl $out/bin/
  '';

  meta = with lib; {
    description = "Gateway API command-line tool";
    homepage = "https://github.com/kubernetes-sigs/gwctl";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = [ ];
  };
}

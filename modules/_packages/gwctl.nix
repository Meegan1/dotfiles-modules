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
    rev = "cb0fc9bc4d070b146f0decae96ddbebb7af79f19"; # You might want to pin to a specific version/commit
    sha256 = "sha256-EigblEwCcOM5/COd2Ttu5RfjW6ukBJTPE1kfQP3fJvk="; # Add SHA after first attempt to build
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

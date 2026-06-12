{
  zig_0_16,
  stdenv,
  fetchFromGitHub,
  apple-sdk,
  lib,
  replaceVars,
}:
let
  zig = zig_0_16;
in
stdenv.mkDerivation (finalAttrs: {
  name = "skhd-zig";
  pname = "skhd-zig";
  version = "v0.1.8";
  src = fetchFromGitHub {
    owner = "jackielii";
    repo = "skhd.zig";
    rev = finalAttrs.version;
    hash = "sha256-Om+Dyayt9lWF61f6LR4UnyA8KPXLOlb9ze/JhRyaPas=";
  };

  # patches = lib.optionals stdenv.hostPlatform.isDarwin [
  #   (replaceVars ./build.patch {
  #     darwin-frameworks = "${apple-sdk.sdkroot}/System/Library/Frameworks";
  #     darwin-include = "${apple-sdk.sdkroot}/usr/include";
  #     darwin-lib = "${apple-sdk.sdkroot}/usr/lib";
  #   })
  # ];

  nativeBuildInputs = [
    zig.hook
  ];

  zigBuildFlags = [
    "-Doptimize=ReleaseFast"
  ];
  meta = {
    description = "Simple Hotkey Daemon for macOS, ported from skhd to Zig.";
    homepage = "https://github.com/jackielii/skhd.zig";
    mainProgram = "skhd";
    name = "skhd-zig";
  };
})

{pkgs ? import <nixpkgs> {}}:

let
  libigloo = pkgs.stdenv.mkDerivation rec {
    pname = "libigloo";
    #version = "local";
    #src = ./icecast-libigloo;
    version = "git";

    src = pkgs.fetchgit {
      url="https://gitlab.xiph.org/xiph/icecast-libigloo";
      rev = "8a551935af7cbc90f2971fce2ba7b3474126fde0";
      sha256 = "ORtoWSN3v9/AC63M5ljEHqYNBu16O94XczPi8QeJgL8=";
    };

    buildInputs = with pkgs; [
      autoconf
      automake
      libtool
      pkg-config
      rhash
      libpthread-stubs
    ];

    installPhase = ''
      ./autogen.sh $out
      ./configure --prefix=$out
      make install
    '';
  };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    autoconf
    automake
    libtool
    pkg-config
    rhash
    libxml2
    libxslt
    curl
    libvorbis
    libtheora
    speex
    libkate
    libopus
    libpthread-stubs
    libigloo
  ];

  shellHook = ''
    echo ${libigloo}
    fish
  '';
}

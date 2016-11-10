{ fetchurl, stdenv, pkgconfig, libgnome_keyring3, glib }:

let
  version = "2.10.0";
in
stdenv.mkDerivation {
  name = "git-credential-gnome-keyring-${version}";

  src = fetchurl {
    url = "https://www.kernel.org/pub/software/scm/git/git-${version}.tar.xz";
    sha256 = "1rr9zyafb6q3wixyjar6cc7z7vdh1dqa4b5irz3gz1df02n68cy7";
  };

  buildInputs = [pkgconfig libgnome_keyring3 glib];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    cd contrib/credential/gnome-keyring
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 git-credential-gnome-keyring $out/bin/
  '';
}

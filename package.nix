{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  version = "v2.0";
  name = "NvChad-${version}";
  src = fetchFromGitHub {
    owner = "NvChad";
    leaveDotGit = true;
    repo = "NvChad";
    rev = "0dcd8a91b69f1fc0fe7064bd404b5390c1c164c5";
    sha256 = "N+Ftw/Poylv2+9QKoteDbKzjB5aOy7NjDRICEmSvsAw=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R * $out
  '';
}

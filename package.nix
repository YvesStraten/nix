{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  version = "v2.0";
  name = "NvChad-${version}";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "0dcd8a91b69f1fc0fe7064bd404b5390c1c164c5";
    sha256 = "N+Ftw/Poylv2+9QKoteDbKzjB5aOy7NjDRICEmSvsAw=";
  };

  nativeBuildInputs = [ makeWrapper ];
  runtimeDeps = [ neovim ];

  installPhase = ''
    mkdir -p $out/.config/nvim
    mkdir -p $out/bin
    cp -R * $out/.config/nvim/
    echo "XDG_CONFIG_HOME=$out/.config nvim" >> $out/bin/NvChad-${version}
    chmod +x $out/bin/NvChad-${version}

    wrapProgram $out/bin/NvChad-${version} \
    --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';
}

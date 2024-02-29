{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  pname = "NvChad-${version}";
  version = "unstable-2024-02-26";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "0dcd8a91b69f1fc0fe7064bd404b5390c1c164c5";
    sha256 = "sha256-N+Ftw/Poylv2+9QKoteDbKzjB5aOy7NjDRICEmSvsAw=";
  };

  nativeBuildInputs = [ makeWrapper ];
  runtimeDeps = [ neovim ];

  installPhase = ''
    mkdir -p $out/.config/nvim
    mkdir -p $out/bin
    cp -R * $out/.config/nvim/
    echo "XDG_CONFIG_HOME=$out/.config nvim" >> $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} \
    --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';
}

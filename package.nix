{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  pname = "NvChad-${version}";
  version = "unstable-2024-03-05";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "13cce81d998630e46b1ad2d60dd10f3013726bb6";
    sha256 = "sha256-0r1H0yO301LMsBwVO0Dec+I8LvaEuVaJ+2hkjNn6qtk=";
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

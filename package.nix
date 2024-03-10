{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  pname = "NvChad-${version}";
  version = "unstable-2024-03-10";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "96ba9ceb0c31c5e595a2b184586805fadaeec864";
    sha256 = "sha256-JfSZPOZXkouJypEShIbOpi5ww/45qE4Upyo8Wu0E91Y=";
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

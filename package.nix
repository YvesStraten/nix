{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  pname = "NvChad-${version}";
  version = "unstable-2024-02-29";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "8fe6a6560eff96238f55701470494ad911eab955";
    sha256 = "sha256-x1y2SkoLNwu0NzmnKxUfl5UQG+SIcW87FhpyZMEHuU8=";
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

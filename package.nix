{ stdenv, fetchFromGitHub, lib, makeWrapper, neovim }:
stdenv.mkDerivation rec {
  pname = "NvChad-${version}";
  version = "unstable-2024-03-09";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "6fb5c313edc966f187c7483a16affaec0518b641";
    sha256 = "sha256-U81M3RFMP7jKirxj3ROCsyqTRXGCrtN6VsPrewlPSLI=";
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

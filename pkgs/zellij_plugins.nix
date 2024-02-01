{ fetchurl, stdenv }: {
  zjstatus = stdenv.mkDerivation {
    name = "zjstatus";
    src = fetchurl {
      url =
        "https://github.com/dj95/zjstatus/releases/download/v0.11.2/zjstatus.wasm";
      hash = "sha256-hv1qCvx9PsXlwRjp8UR1Q85Cuw6SKBoVMrKx7q6cPno=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/plugins
      cp $src $out/plugins/zjstatus.wasm
    '';
  };
  zellij_forgot = stdenv.mkDerivation {
    name = "zellij_forgot";
    src = fetchurl {
      url =
        "https://github.com/karimould/zellij-forgot/releases/download/0.2.0/zellij_forgot.wasm";
      hash = "sha256-Gkl7ARJPp+ljCPHDwKdFDlgxD1w1y0d1GscOhMa95II=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/plugins
      cp $src $out/plugins/zellij_forgot.wasm
    '';
  };
}

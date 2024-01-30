{ fetchurl, stdenv }: {
  zjstatus = stdenv.mkDerivation {
    name = "zjstatus.wasm";
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
}

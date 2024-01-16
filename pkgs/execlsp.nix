{ lib,
  buildGoModule,
  fetchFromGitHub,
  name ? "exec-lsp",
  version ? "1.0.1",
  hash ? "sha256-/U8oWYhuYw/8t7vWAErWEcvF1AtVtpox/MBgjAHsKyA=",
  vendorHash ? "sha256-SUG7ldwOOWNKtrCrLgBFvwILTIy4kOZGfra7VfwJIXc="
}:  buildGoModule {
  pname = "${name}";
  version = "${version}";

  src = fetchFromGitHub {
    owner = "kpabijanskas";
    repo = "${name}";
    rev = "v${version}";
    hash = "${hash}";
  };

  vendorHash = "${vendorHash}";

  #hack for it to actually show up in bin..
  postInstall = ''
      mv $out/bin/${name} $out/bin/${name}1
      mv $out/bin/${name}1 $out/bin/${name}
  '';

  meta = with lib; {
    description = "Exec LSP is a very simple LSP server to execute commands.";
    homepage = "https://github.com/kpabijanskas/exec-lsp";
    license = licenses.gpl3;
  };
}

{ lib,
  buildGoModule,
  fetchFromGitHub,
  name ? "ejson-templater",
  version ? "1.0.1",
  hash ? "sha256-7tdxGv2s8652Xe4WvXErHhoXARAXDQptb8jpM1MbIp8=",
  vendorHash ? "sha256-p5/w5uiUQ00IImQJjxClxnMX6yljhdTKoxJqA7lqeK0="
}: buildGoModule {
  pname = "${name}";
  version = "${version}";

  src = fetchFromGitHub {
    owner = "kpabijanskas";
    repo = "${name}";
    rev = "v${version}";
    hash = "${hash}";
  };

  vendorHash = "${vendorHash}";

  postInstall = ''
      mv $out/bin/templater $out/bin/${name}
  '';

  meta = with lib; {
		description = "ejson-templater";
    homepage = "https://github.com/kpabijanskas/ejson-templater";
    license = licenses.mit;
  };
}

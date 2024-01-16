{ lib, buildGoModule }:

buildGoModule {
  pname = "dategenforzk";
  version = "0.0.1";

  src = ./dategenforzk;

  vendorHash = null;

  meta = with lib; {
    description = "Date generator for zk";
    license = licenses.mit;
  };
}

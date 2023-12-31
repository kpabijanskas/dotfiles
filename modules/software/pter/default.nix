# Generated by pip2nix 0.8.0.dev1
# See https://github.com/nix-community/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "cursedspace" = super.buildPythonPackage {
    pname = "cursedspace";
    version = "1.5.2";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b1/18/a60d7d348fdf9e4d5d5be31630b339d7e0b11b13705062c12c6320aab282/cursedspace-1.5.2-py3-none-any.whl";
      sha256 = "19x6vqdn49vsy6a3pgc12zrn8px13p137kjwyprmza8wlld7vir9";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
  "pter" = super.buildPythonPackage {
    pname = "pter";
    version = "3.12.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/0a/18/69966444d3cd6b078ece7e7ba3256d05811275a2a5b4cb9942e70465c2f5/pter-3.12.0-py3-none-any.whl";
      sha256 = "0v4jpbr54wmcqj94lifq8m411gfd0krayadc3c0pzjbyc24g2wq0";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [
      self."cursedspace"
      self."pytodotxt"
    ];
  };
  "pytodotxt" = super.buildPythonPackage {
    pname = "pytodotxt";
    version = "1.5.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/84/ad/ba5e78667b92c21c751b3f6205e6a34f61fe43461a7bae6854d87cdbb0d2/pytodotxt-1.5.0-py3-none-any.whl";
      sha256 = "0836y6s07dqwvalcxgbidbnwgzljcnsx1pajvsh07aiyv1zj6gj2";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
}
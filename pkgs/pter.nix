{ pkgs }:
let 
  buildPythonPackage = pkgs.python3Packages.buildPythonPackage;
  fetchurl = pkgs.fetchurl;
in rec {
  cursedspace = buildPythonPackage {
    pname = "cursedspace";
    version = "1.5.2";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/b1/18/a60d7d348fdf9e4d5d5be31630b339d7e0b11b13705062c12c6320aab282/cursedspace-1.5.2-py3-none-any.whl";
      sha256 = "19x6vqdn49vsy6a3pgc12zrn8px13p137kjwyprmza8wlld7vir9";
    };
    format = "wheel";
    doCheck = false;
  };
  pytodotxt = buildPythonPackage {
    pname = "pytodotxt";
    version = "1.5.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/84/ad/ba5e78667b92c21c751b3f6205e6a34f61fe43461a7bae6854d87cdbb0d2/pytodotxt-1.5.0-py3-none-any.whl";
      sha256 = "0836y6s07dqwvalcxgbidbnwgzljcnsx1pajvsh07aiyv1zj6gj2";
    };
    format = "wheel";
    doCheck = false;
  };
  pter = buildPythonPackage {
    pname = "pter";
    version = "3.13.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/05/15/cebee3661615816a7849a3414b32089eed8b202e761ed76208da6184201c/pter-3.13.0-py3-none-any.whl";
      sha256 = "sha256-8aIFFkgMCi5oly4QitAZyCU8ftkXS99r7N1CdVWYniw=";
    };
    format = "wheel";
    doCheck = false;
    propagatedBuildInputs = [
      cursedspace
      pytodotxt
    ];
  };
}

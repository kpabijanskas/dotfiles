{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      exercism
    ];
    file = {
      ".config/exercism/user.json" = {
        source = ../generated/exercism_user.json;
      };
    };
  };
}

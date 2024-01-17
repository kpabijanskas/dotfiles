{
  pkgs,
  ...
}: let
  ejson-templater = pkgs.callPackage ../pkgs/ejson-templater.nix {};
  scripts = pkgs.callPackage ../pkgs/todo_scripts.nix {};
in {
  home = {
    packages = with pkgs; with scripts; [
      add_project_todo
      project_todos
      open_project_file
      ejson-templater
      arping
      bpftools
      coreutils
      cscope
      ctags
      docker
      clang
      cmake
      consul
      ejson
      fd
      gawk
      gdb
      gnumake
      grpc
      httpie
      ipcalc
      just
      libbpf
      litecli
      lua
      lua52Packages.luarocks
      mage
      mosh
      most
      ngrep
      nodejs_21
      openssl
      openvpn
      perl
      php83
      php83Packages.composer
      podman
      protobuf
      protoc-gen-go-grpc
      pwgen
      redis
      rustup
      serfdom
      shellcheck
      shfmt
      socat
      sqlite
      speedtest-cli
      tshark
      teleport_12 # newer doesn't work atm
      typescript
      util-linux
      vagrant
      vault
      wireguard-go
      wireguard-tools
      yarn
      zip
    ];
    file = {
      ".golangci.yml" = {
        source = ../files/golangci.yml;
      };
      ".config/gdb/gdbinit" = {
        text = "set history save on";
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
  };

  services = {
    home-manager = {
      autoUpgrade = {
        enable = true;
        frequency = "daily";
      };
    };
  };

  home.stateVersion = "24.05";
}

{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
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
      lua
      lua52Packages.luarocks
      mage
      mosh
      most
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
      python311Full
      python311Packages.pip
      python311Packages.ipython
      redis
      rustup
      serfdom
      shellcheck
      shfmt
      socat
      sqlite
      speedtest-cli
      tshark
      teleport_11 # newer doesn't work atm
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

  home.stateVersion = "23.11";
}

{ pkgs, ... }:
let ejson-templater = pkgs.callPackage ../pkgs/ejson-templater.nix { };
in {
  home = {
    packages = with pkgs; [
      cloc
      delve
      python311Packages.python-lsp-server
      lldb
      just
      upx
      sqlite
      socat
      inetutils
      # gomobile
      iftop
      curlFull
      direnv
      python311Packages.ipython
      jq
      nmap
      pipenv

      go
      libgcc
      # gcc
      llvm
      clang
      libunwind
      liblogging
      glib

      ejson-templater
      arping
      bpftools
      coreutils
      cscope
      ctags
      docker
      cmake
      consul
      ejson
      fd
      gotools
      goimports-reviser
      gofumpt
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
      wireguard-tools
      yarn
      zip
    ];
    file = {
      ".golangci.yml" = { source = ../files/golangci.yml; };
      ".config/gdb/gdbinit" = { text = "set history save on"; };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    android_sdk.accept_license = true;
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

  news.display = "silent";
  home.stateVersion = "24.05";
}

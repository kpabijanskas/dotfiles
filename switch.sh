#!/bin/bash
ejson-templater -srcDir ./templates -secretsFile ~/.secrets.ejson -dstDir ./generated
nix flake update
home-manager switch --flake .#"$(hostname -f)" -b backup 


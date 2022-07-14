{ config, pkgs, lib, ... }:
{
  programs.go.enable = true;
  programs.go.package = pkgs.go_1_18;
}


{ ... }: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;
}

{config , pkgs , lib, ... }:
{
  services.redis.enable = true;
  services.redis.extraConfig = "--daemonize yes";
}

{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";
  };
}

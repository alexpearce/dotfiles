# Join my home Wi-Fi network automatically.
{
  flake.modules.nixos.wifi =
    { config, ... }:
    {
      age.secrets.pearwinternet.file = ../../secrets/pearwinternet.age;

      networking.networkmanager = {
        enable = true;
        ensureProfiles = {
          environmentFiles = [
            config.age.secrets.pearwinternet.path
          ];
          profiles = {
            "Pearwinternet" = {
              connection = {
                id = "Pearwinternet";
                type = "wifi";
                autoconnect = "true";
              };
              wifi = {
                ssid = "Pearwinternet";
                mode = "infrastructure";
              };
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk = "$WIFI_PASSWORD";
              };
              ipv4.method = "auto";
              ipv6.method = "auto";
            };
          };
        };
      };
    };
}

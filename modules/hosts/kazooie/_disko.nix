{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            # Boot partition.
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            # Swap partition (for suspend-to-disk hibernation).
            swap = {
              # Matches the device's 24 GB of RAM.
              size = "24G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };

            # Main partition.
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  # Root subvolume.
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # Home subvolume for user data.
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # Nix store subvolume.
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

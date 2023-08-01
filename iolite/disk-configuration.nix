{ ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            }
          ];
        };
      };
    };
  };
}

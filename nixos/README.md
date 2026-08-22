# NixOS Config

This flake has one shared system config and separate host configs for hardware-specific settings.

## Rebuild

Desktop:

```sh
sudo nixos-rebuild switch --flake /home/semir/dev/config/nixos#desktop
```

Laptop:

```sh
sudo nixos-rebuild switch --flake /home/semir/dev/config/nixos#laptop
```

## Layout

- `common.nix`: shared NixOS settings, packages, users, services, and programs.
- `hosts/desktop/configuration.nix`: desktop host entrypoint.
- `hosts/desktop/hardware-configuration.nix`: desktop disk, boot, swap, and hardware config.
- `hosts/laptop/configuration.nix`: laptop host entrypoint.
- `hosts/laptop/hardware-configuration.nix`: laptop disk, boot, swap, and hardware config.

Keep `hardware-configuration.nix` files per host. They should not be shared across machines.

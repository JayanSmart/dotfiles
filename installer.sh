#!/bin/sh
parted /dev/''${DISK} -- mklabel gpt
parted /dev/''${DISK} -- mkpart primary 512MiB 100%
parted /dev/''${DISK} -- mkpart ESP fat32 1MiB 512MiB
parted /dev/''${DISK} -- set 3 esp on
mkfs.ext4 -L nixos /dev/''${DISK}''${PARTITION_PREFIX}1
mkfs.fat -F 32 -n boot /dev/''${DISK}''${PARTITION_PREFIX}2

mount /dev/disk/by-label/nixos /mnt
mkdir --parents /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

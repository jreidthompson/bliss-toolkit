#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# Install extlinux bootloader

wecho "Installing extlinux bootloader"

PREFIX="/mnt/gentoo"
LDR_DIR="extlinux" # Loader Directory
DRIVE="/dev/sda"

# Install bootloader and copy config and menu file
extlinux --install ${PREFIX}/boot/${LDR_DIR}

cp resources/configs/extlinux.conf ${PREFIX}/boot/${LDR_DIR}
cp /usr/share/syslinux/menu.c32 ${PREFIX}/boot/${LDR_DIR}

# Set BIOS Legacy Flag
sgdisk ${DRIVE} --attributes=1:set:2

# Flash GPT/MBR file to drive
dd conv=notrunc bs=440 count=1 if=/usr/share/syslinux/gptmbr.bin of=${DRIVE}

#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

mount /dev/vg/root /mnt/gentoo
mount /dev/vg/portage /mnt/gentoo/usr/portage
mount /dev/vg/src /mnt/gentoo/usr/src
mount /dev/vg/var /mnt/gentoo/var
mount /dev/vg/home /mnt/gentoo/home
mount /dev/sda1 /mnt/gentoo/boot

swapon /dev/vg/swap

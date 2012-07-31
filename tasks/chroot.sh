#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

mount -o bind /proc /mnt/gentoo/proc
mount -o bind /dev /mnt/gentoo/dev
mount -o bind /sys /mnt/gentoo/sys

env -i HOME=/root TERM=$TERM chroot /mnt/gentoo /bin/bash --login

#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

wecho "Unmounting Filesystems"

MOUNTPOINTS="\
/mnt/gentoo/boot \
/mnt/gentoo/home \
/mnt/gentoo/var \
/mnt/gentoo/usr/src \
/mnt/gentoo/usr/portage \
/mnt/gentoo/proc \
/mnt/gentoo/dev \
/mnt/gentoo/sys \
/mnt/gentoo \
"

for x in ${MOUNTPOINTS}; do
	umount ${x}
done

swapoff /dev/vg/swap

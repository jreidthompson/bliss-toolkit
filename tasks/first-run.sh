#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# Before you run the mount script, run this to create
# the folders for the mountpoints to mount to

wecho "Creating default directories for mounting your filesystems to"

PREFIX=/mnt/gentoo

mount /dev/vg/root ${PREFIX}

DEFAULT_DIRS="boot home var usr/portage usr/src"

for x in ${DEFAULT_DIRS}; do
	mkdir -p ${PREFIX}/${x}
done

umount ${PREFIX}

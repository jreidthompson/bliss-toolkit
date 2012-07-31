#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

PREFIX="/mnt/gentoo"

wecho "Copying configurations and stage/portage .tar.xz to ${PREFIX}"

# Copy over network config
cp -f /etc/resolv.conf ${PREFIX}/etc

# Copy over stage3 and portage
cp -f files/* ${PREFIX}

# Copy kernel config
cp -f resources/configs/config-3.5.0-ALL ${PREFIX}/usr/src

# Copy fstab
cp -f resources/configs/fstab ${PREFIX}/etc

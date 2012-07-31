#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# Import functions
. ../resources/functions_generic.sh

# Installs Funtoo Linux

# Funtoo Stable x64 Generic
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-64bit/generic_64/stage3-latest.tar.xz"

# Funtoo Current x64 Generic
FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-64bit/generic_64/stage3-latest.tar.xz"

# Funtoo Stable x32 i686 
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-32bit/i686/stage3-latest.tar.xz"

# Funtoo Current x32 i686 
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-32bit/i686/stage3-latest.tar.xz"

# Funtoo Portage
PFLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/snapshots/portage-latest.tar.xz"

# Stage/Portage file names
STAGE="stage3-latest.tar.xz"
PORTAGE="portage-latest.tar.xz"

PREFIX="/mnt/gentoo"

wecho "Checking to see if you have ${STAGE}"
# Download Stage 3 and Portage
if [ ! -f "${STAGE}" ]; then
	wecho "Downloading ${STAGE}"
	wget ${FLAVOR}
else
	wecho "You already have ${STAGE} :)."
fi

wecho "Checking to see if you have ${PORTAGE}"
if [ ! -f "${PORTAGE}" ]; then
	wecho "Downloading ${PORTAGE}"
	wget ${PFLAVOR}
else
	wecho "You already have ${PORTAGE} :)."
fi

# Extract Stage3 and Portage
wecho "Extracting ${STAGE}"
tar -xJpf ${STAGE} -C ${PREFIX}
wecho "Extracting ${PORTAGE}"
tar -xJf ${PORTAGE} -C ${PREFIX}/usr

echo "After you chroot, go into the /usr/portage directory and set"
echo "your brand to point to funtoo.org."
echo "Issue a 'git checkout funtoo.org'"

wecho "Complete"

exit

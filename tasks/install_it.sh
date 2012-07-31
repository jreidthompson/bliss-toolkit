#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# Installs Funtoo Linux

# Stage/Portage file names
STAGE="stage3-latest.tar.xz"
PORTAGE="portage-latest.tar.xz"

# Funtoo Stable x64 Generic
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-64bit/generic_64/${STAGE}"

# Funtoo Current x64 Generic
FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-64bit/generic_64/${STAGE}"

# Funtoo Stable x32 i686 
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-32bit/i686/${STAGE}"

# Funtoo Current x32 i686 
#FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-32bit/i686/${STAGE}"

# Funtoo Portage
PFLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/snapshots/${PORTAGE}"

PREFIX="/mnt/gentoo"
FILES_DIR="files"

wecho "Checking to see if you have ${STAGE}"
# Download Stage 3 and Portage
if [ ! -f "${FILES_DIR}/${STAGE}" ]; then
	wecho "Downloading ${STAGE}"
	wget ${FLAVOR}
else
	wecho "You already have ${STAGE} :)."
fi

wecho "Checking to see if you have ${PORTAGE}"
if [ ! -f "${FILES_DIR}/${PORTAGE}" ]; then
	wecho "Downloading ${PORTAGE}"
	wget ${PFLAVOR}
else
	wecho "You already have ${PORTAGE} :)."
fi

# Extract Stage3 and Portage
wecho "Extracting ${STAGE}"
tar -xJpf ${FILES_DIR}/${STAGE} -C ${PREFIX}
wecho "Extracting ${PORTAGE}"
tar -xJf ${FILES_DIR}/${PORTAGE} -C ${PREFIX}/usr

echo "After you chroot, go into the /usr/portage directory and set"
echo "your brand to point to funtoo.org."
echo "Issue a 'git checkout funtoo.org'"

wecho "Complete"

exit

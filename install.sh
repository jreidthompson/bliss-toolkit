#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# Import Functions
source resources/functions_generic.sh

# Partition
source tasks/partition.sh

if [ "${?}" -eq 0 ]; then
        # Make directories to mount others
        source tasks/first-run.sh

        # Mount everything
        source tasks/mount-all.sh

        # Download & Install Stage3 & Portage
        source tasks/install_it.sh

        # Copy other stuff (like resolv.conf)
        source tasks/cp_stuff.sh

	# Install bootloader (if you want)
	echo -n "Do you want to install the extlinux bootloader? [y/N]"
	read choice

	case ${choice} in
	y)
		source tasks/bootloader.sh
		;;
	*)
		wecho "A bootloader will not be installed"
		;;
	esac

        # Chroot into new install
        source tasks/chroot.sh
else
        echo "Error"
        exit 1
fi

exit

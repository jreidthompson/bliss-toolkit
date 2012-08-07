#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

# "Wide print" - prints with 1 space borders
wecho()
{
	echo ""
	echo "##### ${1} #####"
	echo ""
}

# Prints empty line
eline()
{
	echo ""
}

err()
{
	echo "${1}" && exit
}

werr()
{
	echo ""
	echo "##### ${1} #####"
	echo ""
	exit
}

get_latest()
{
	# Option 1 = Gentoo i686
	# Option 2 = Gentoo x64

	local FILE="latest-stage3.txt"
	
	if [[ "${1}" -eq 1 ]]; then
		local URL="http://mirror.rit.edu/gentoo/releases/x86/autobuilds/${FILE}"
	elif [[ "${1}" -eq 2 ]]; then
		local URL="http://mirror.rit.edu/gentoo/releases/amd64/autobuilds/${FILE}"
	else
		err "There was a problem checking which Gentoo you wanted"
	fi

	if [[ ! -f "${FILE}" ]]; then
		wget ${URL}
	fi

	if [[ "${1}" -eq 1 ]]; then
		local t=$(sed -n '4p' ${FILE})
	elif [[ "${1}" -eq 2 ]]; then
		local t=$(sed -n '3p' ${FILE})
	else
		err "There was a problem checking which Gentoo you wanted"
	fi

	STAGE=${t#*/}

	echo "Latest: ${STAGE}"

	# clean up
	rm ${FILE}
}

# Message that will be displayed at the top of the screen
print_header()
{
	echo "##################################"
	echo "${JV_APP_NAME} - v${JV_VERSION}"
	echo "Author: ${JV_CONTACT}"
	echo "Distributed under the ${JV_LICENSE} license"
	echo "##################################"
	eline
}

print_options()
{
	echo "1. Gentoo [i686]"
	echo "2. Gentoo [x64]"
	echo "3. Funtoo Stable [i686]"
	echo "4. Funtoo Stable [x64]"
	echo "5. Funtoo Current [i686]"
	echo "6. Funtoo Current [x64]"
	echo "7. Exit"
}

# Display the menu which lets users pick which flavor they want to install
menu_stage()
{
	PORTAGE="portage-latest.tar.xz"

	# Check to see if a menu option was passed
	if [[ -z "${choice}" ]]; then
		echo "Which flavor do you want to install:"
		print_options
		eline
		echo -n "Current choice: " && read choice
		eline
	fi

	# Set a few variables just before the case statement comes into effect
	case ${choice} in
	1|2)
		MESSAGE="Gentoo"
		PFLAVOR="http://mirror.rit.edu/gentoo/snapshots/${PORTAGE}"
		;;
	3|4|5|6)
		MESSAGE="Funtoo"
		STAGE="stage3-latest.tar.xz"
		PFLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-experimental/snapshots/${PORTAGE}"
		;;
	7)
		wecho "Exiting" && exit
		;;
	*)
		print_options
		err "Invalid choice. Exiting"
		;;
	esac

	case ${choice} in
	1)
		# Get the latest Gentoo filename
		get_latest 1

		# Gentoo Linux x86_32 i686
		FLAVOR="http://mirror.rit.edu/gentoo/releases/x86/current-stage3/${STAGE}"
		;;
	2)
		# Get the latest Gentoo filename
		get_latest 2

		# Gentoo Linux x86_64
		FLAVOR="http://mirror.rit.edu/gentoo/releases/amd64/current-stage3/${STAGE}"
		;;
	3)
		# Funtoo Stable x86_32 i686 
		FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-32bit/i686/${STAGE}"
		;;
	4)
		# Funtoo Stable x86_64 Generic
		FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-64bit/generic_64/${STAGE}"
		;;
	5)
		# Funtoo Current x86_32 i686 
		FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-32bit/i686/${STAGE}"
		;;
	6)
		# Funtoo Current x86_64 Generic
		FLAVOR="http://ftp.osuosl.org/pub/funtoo/funtoo-current/x86-64bit/generic_64/${STAGE}"
		;;
	7)
		wecho "Exiting" && exit
		;;
	*)
		err "Invalid choice. Exiting"
		;;
	esac
}

#!/bin/bash

# Copyright (C) 2012 Jonathan Vasquez <jvasquez1011@gmail.com>
#
# Distributed under the ISC license which can be found in the LICENSE file.

DRIVE="/dev/sda"

# Drive that contains the Physical volume for LVM
PV_DRIVE="/dev/sda2"

VG_NAME="vg"

LV="swap root portage var src home"

SWAP_NAME="swap"
SWAP_SIZE="9G"

ROOT_NAME="root"
ROOT_SIZE="10G"

PORTAGE_NAME="portage"
PORTAGE_SIZE="10G"

VAR_NAME="var"
VAR_SIZE="15G"

SRC_NAME="src"
SRC_SIZE="10G"

HOME_NAME="home"
HOME_SIZE="20G"

##### Other #####

# Filesystem strings for sgdisk
LINUX="Linux filesystem"
LVM="Linux LVM"

# Filesystem to use on all logical volumes
FSTYPE="ext4"

##### Create Partition Layout #####
echo "This will delete your entire drive: ${DRIVE}"
echo -n "Are you sure you want to do this? [y/N]"
read choice
clear

case ${choice} in
y)
	# Make sure partitions are unmounted
	source tasks/umount-all.sh

	# First we will remove any old lvm partition labels on the target lvm part
	wecho "Removing old LVM labels from ${PV_DRIVE}"
	vgchange -a n
	pvremove -ff ${PV_DRIVE}

	wecho "Creating new partition layout on ${DRIVE}"
	sgdisk -Z ${DRIVE}
	sgdisk -o ${DRIVE}

	# Let kernel know that partition layout changed
	wecho "Partprobing"
	partprobe

	wecho "Creating the partitions"
	
	# Create and label boot partition
	wecho " Creating boot partition "
	sgdisk -n 1:2048:+250M ${DRIVE}
	sgdisk -t 1:8300 ${DRIVE}
	sgdisk -c 1:"${LINUX}" ${DRIVE}

	# Create and label LVM partition
	wecho " Creating LVM partition "
	sgdisk -n 2:0:0 ${DRIVE}
	sgdisk -t 2:8e00 ${DRIVE}
	sgdisk -c 2:"${LVM}" ${DRIVE}

	wecho "Partition layout created successfully!"
	;;
*)
	wecho "Nothing will be done.. exiting"
	exit 1
	;;
esac

##### Create #####

wecho "Creating LVM PV, VG, & LVs"
pvcreate ${PV_DRIVE}

vgcreate ${VG_NAME} ${PV_DRIVE}

lvcreate -C y -L ${SWAP_SIZE} -n ${SWAP_NAME} ${VG_NAME}
lvcreate -L ${ROOT_SIZE} -n ${ROOT_NAME} ${VG_NAME}
lvcreate -L ${PORTAGE_SIZE} -n ${PORTAGE_NAME} ${VG_NAME}
lvcreate -L ${VAR_SIZE} -n ${VAR_NAME} ${VG_NAME}
lvcreate -L ${SRC_SIZE} -n ${SRC_NAME} ${VG_NAME}
lvcreate -L ${HOME_SIZE} -n ${HOME_NAME} ${VG_NAME}

wecho "Formatting Partitions with ${FSTYPE}"

for x in ${LV}; do
	if [ "${x}" != "swap" ]; then
		mkfs.${FSTYPE} /dev/${VG_NAME}/${x}
	else
		mkswap /dev/${VG_NAME}/${x}
	fi
done 

wecho "Congratulations, your partitions are ready to be mounted!"

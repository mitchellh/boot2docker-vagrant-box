#!/bin/sh

set -x
set -e

MNT_TMP_DIR="/tmp/mnt"
EXTRACT_DIR="/tmp/extract"
NEW_ISO_DIR="/tmp/newiso"
B2D_ISO_PATH="/tmp/boot2docker-orig.iso"
NEW_B2D_ISO_PATH="/tmp/boot2docker-vagrant.iso"

rm -rf "${MNT_TMP_DIR}" "${EXTRACT_DIR}" "${NEW_ISO_DIR}"
mkdir -p "${NEW_ISO_DIR}" "${EXTRACT_DIR}" "${MNT_TMP_DIR}" /mnt/syslinux

# Install some custom tools on boot2docker
# Note that even if the install worked, tce-loa return exit code to 1...
su -c "tce-load -w -i mkisofs-tools" docker || :
su -c "tce-load -w -i compiletc" docker || :
curl -L -o /tmp/syslinux.tcz http://tinycorelinux.net/6.x/x86/tcz/syslinux.tcz
mount /tmp/syslinux.tcz /mnt/syslinux -o loop,ro

# Extract the initrd.img (Linux root filesystem) from the iso
mount "${B2D_ISO_PATH}" "${MNT_TMP_DIR}" -o loop,ro
cp -a "${MNT_TMP_DIR}/boot" "${NEW_ISO_DIR}/"
cp -a "${MNT_TMP_DIR}/version" "${NEW_ISO_DIR}/"
umount "${MNT_TMP_DIR}"

# Unarchive the initrd.img to a Folder in $ROOTFS
# uncompress with xz and use cpio to transcript to files/dirs
# See https://github.com/boot2docker/boot2docker/blob/master/rootfs/make_iso.sh#L38 
mv "${NEW_ISO_DIR}/boot/initrd.img" "${EXTRACT_DIR}/initrd.xz"
cd "${EXTRACT_DIR}"
/usr/local/bin/unxz -9 --format=lzma -d "${EXTRACT_DIR}/initrd.xz" --stdout | cpio -i -H newc -d
cd -
rm -f "${EXTRACT_DIR}/initrd.xz"

# Install our custom tcz
for TCZ_PACKAGE in popt rsync; do
	curl -LO "http://tinycorelinux.net/5.x/x86/tcz/${TCZ_PACKAGE}.tcz"; \
	mount -o loop "./${TCZ_PACKAGE}.tcz" "${MNT_TMP_DIR}"
	cd "${MNT_TMP_DIR}"
	cp -a ./* "${EXTRACT_DIR}/"
	cd -
	umount "${MNT_TMP_DIR}"
done

# Add option to the /opt/bootlocal.sh script
echo "/usr/local/etc/init.d/nfs-client start" | tee -a "${EXTRACT_DIR}/opt/bootlocal.sh"

# Generate the new initrd.img in new iso dir
cd "${EXTRACT_DIR}"
find | cpio -o -H newc | /usr/local/bin/xz -9 --format=lzma > "${NEW_ISO_DIR}/boot/initrd.img"
cd -

# Last part will need to recompile ourself xorriso since syslinux (with isohybrid) nor xorriso exists as it in TCL in 64Bits

XORRISO_VERSION=1.4.0
curl -L -o "/tmp/xorriso-${XORRISO_VERSION}.tar.gz" "http://www.gnu.org/software/xorriso/xorriso-${XORRISO_VERSION}.tar.gz"
tar -x -z -f "/tmp/xorriso-${XORRISO_VERSION}.tar.gz" -C /tmp/
cd "/tmp/xorriso-${XORRISO_VERSION}"
./configure
make
make install
cd -

# Create our new ISO in MBR-hybrid format with Xorriso
# /usr/local/bin/xorriso -l -J -R -V "Custom Boot2docker v$(cat ${NEW_ISO_DIR}/version)" \
# 	-no-emul-boot -boot-load-size 4 \
#  	-boot-info-table -b boot/isolinux/isolinux.bin \
#  	-c boot/isolinux/boot.cat -o "${NEW_B2D_ISO_PATH}" "${NEW_ISO_DIR}"

/usr/local/bin/xorriso  \
    -publisher "Damien DUPORTAL" \
    -as mkisofs \
    -l -J -R -V "Custom Boot2Docker-v$(cat ${NEW_ISO_DIR}/version)" \
    -no-emul-boot -boot-load-size 4 -boot-info-table \
    -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat \
    -isohybrid-mbr /mnt/syslinux/usr/local/share/syslinux/isohdpfx.bin \
    -o "${NEW_B2D_ISO_PATH}" "${NEW_ISO_DIR}"


#
# Copyright (C) 2010 OpenWrt.org
#

PART_NAME=firmware
REQUIRE_IMAGE_METADATA=1

RAMFS_COPY_BIN='fw_printenv fw_setenv devmem'
RAMFS_COPY_DATA='/etc/fw_env.config /var/lock/fw_printenv.lock'

platform_check_image() {
	case "$(board_name)" in
	bodybytes,bodybytes)
		local gz part_name part_dev

		[ "$(identify_magic_long "$(get_magic_long "$1" cat)")" = "gzip" ] && gz="z"

		tar t${gz}f "$1" 2>/dev/null | grep -q "sysupgrade-.*/CONTROL" || {
			echo "Not a sysupgrade tar archive"
			return 1
		}

		for part_name in "kernel" "rootfs"; do
			part_dev="$(find_mmc_part "$part_name")"
			[ -n "$part_dev" ] || {
				echo "eMMC partition \"$part_name\" not found"
				return 1
			}
		done
		;;
	esac

	return 0
}

platform_copy_config() {
	case "$(board_name)" in
	bodybytes,bodybytes)
		emmc_copy_config
		;;
	esac
}

platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
	bodybytes,bodybytes)
		CI_KERNPART="kernel"
		CI_ROOTPART="rootfs"
		CI_DATAPART="rootfs_data"
		devmem 0x1000006c 32 0xB0010000
		emmc_do_upgrade "$1"
		;;
	alfa-network,awusfree1)
		[ "$(fw_printenv -n dual_image 2>/dev/null)" = "1" ] &&\
		[ -n "$(find_mtd_part backup)" ] && {
			PART_NAME=backup
			if [ "$(fw_printenv -n bootactive 2>/dev/null)" = "1" ]; then
				fw_setenv bootactive 2 || exit 1
			else
				fw_setenv bootactive 1 || exit 1
			fi
		}
		default_do_upgrade "$1"
		;;
	tplink,archer-c20-v5|\
	tplink,archer-c50-v4|\
	tplink,archer-c50-v6)
		MTD_ARGS="-t romfile"
		default_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
}

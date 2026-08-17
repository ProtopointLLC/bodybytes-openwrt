# SPDX-License-Identifier: MPL-2.0

include $(TOPDIR)/rules.mk

PKG_NAME:=bodybytes-provision
PKG_RELEASE:=1

PKG_LICENSE:=MPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/bodybytes-provision
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Bodybytes field provisioning
  DEPENDS:=+kmod-mtd-rw +uboot-envtools +parted +blkdiscard +e2fsprogs
  PKGARCH:=all
endef

define Package/bodybytes-provision/description
  Field provisioning tool for bodybytes devices: set-mac, set-branding, and format-emmc.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/bodybytes-provision/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/bodybytes-provision $(1)/usr/sbin/bodybytes-provision
endef

$(eval $(call BuildPackage,bodybytes-provision))

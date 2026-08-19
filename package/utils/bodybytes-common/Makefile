# SPDX-License-Identifier: MPL-2.0

include $(TOPDIR)/rules.mk

PKG_NAME:=bodybytes-common
PKG_RELEASE:=1

PKG_LICENSE:=MPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/bodybytes-common
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Bodybytes board customizations
  DEPENDS:=+uboot-envtools +avahi-daemon +openssl-util
  PKGARCH:=all
endef

define Package/bodybytes-common/description
  Board customizations for bodybytes devices: first-boot defaults, network self-heal, and login niceties.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/bodybytes-common/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/90_defaults $(1)/etc/uci-defaults/90_defaults

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/avahi-reprobe $(1)/etc/init.d/avahi-reprobe
	$(INSTALL_BIN) ./files/etc/init.d/ttyd-reprobe $(1)/etc/init.d/ttyd-reprobe
	$(INSTALL_BIN) ./files/etc/init.d/dufs-dirs $(1)/etc/init.d/dufs-dirs

	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DATA) ./files/etc/hotplug.d/iface/99-avahi-mdns $(1)/etc/hotplug.d/iface/99-avahi-mdns
endef

$(eval $(call BuildPackage,bodybytes-common))

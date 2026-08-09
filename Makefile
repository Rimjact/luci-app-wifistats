include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-wifistats
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Rimjact <rimjact@ya.ru>

# Пакет не зависит от архитектуры
PKGARCH:=all

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-wifi-stats
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Applications
  TITLE:=Wi-Fi client statistics for LuCI
  DEPENDS:=+luci-base +lua +lua-cjson +libubus-lua +procd
endef

define Package/luci-app-wifi-stats/description
  Collects daily Wi-Fi client statistics and displays them in LuCI.
endef

# Исходники компилировать не требуется
define Build/Compile
endef

define Package/luci-app-wifistats/install
 $(INSTALL_DIR) $(1)/etc/init.d
 $(INSTALL_BIN) ./root/etc/init.d/wifistats \
  $(1)/etc/init.d/wifi-stats

 $(INSTALL_DIR) $(1)/usr/bin
 $(INSTALL_BIN) ./root/usr/bin/wifistats \
  $(1)/usr/bin/wifistats

 $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
 $(INSTALL_DATA) ./root/usr/lib/lua/luci/controller/wifistats.lua \
  $(1)/usr/lib/lua/luci/controller/wifistats.lua

 $(INSTALL_DIR) $(1)/usr/share/luci/view
 $(INSTALL_DATA) ./root/usr/share/luci/view/wifistats.htm \
  $(1)/usr/share/luci/view/wifistats.htm

 $(INSTALL_DIR) $(1)/etc/wifistats
endef

define Package/luci-app-wifistats/conffiles
/etc/wifistats/
endef

$(eval $(call BuildPackage,luci-app-wifistats))

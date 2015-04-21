# -*-makefile-*-
#
# Copyright (C) 2010 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLUEZ) += bluez

#
# Paths and names
#
BLUEZ_VERSION	:= 4.89
BLUEZ		:= bluez-$(BLUEZ_VERSION)
BLUEZ_SUFFIX	:= tar.gz
BLUEZ_URL	:= http://www.kernel.org/pub/linux/bluetooth/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_SOURCE	:= $(SRCDIR)/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_DIR	:= $(BUILDDIR)/$(BLUEZ)
BLUEZ_LICENSE	:= GPLv2+ LGPLv2.1+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BLUEZ_SOURCE):
	@$(call targetinfo)
	@$(call get, BLUEZ)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BLUEZ_PATH	:= PATH=$(CROSS_PATH)
BLUEZ_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BLUEZ_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--enable-audio \
	--enable-bccmd \
	--disable-capng \
	--enable-configfiles \
	--disable-cups \
	--enable-debug \
	--disable-dfutool \
	--disable-dund \
	--disable-fortify \
	--disable-hid2hci \
	--disable-hidd \
	--enable-input \
	--enable-libtool-lock \
	--disable-maemo6 \
	--disable-netlink \
	--enable-network \
	--enable-optimization \
	--enable-pand \
	--disable-pcmcia \
	--disable-pie \
	--disable-pnat \
	--enable-serial \
	--enable-service \
	--enable-shared \
	--disable-static \
	--enable-test \
	--disable-tracer \
	--enable-tools \
	--enable-udevrules \
	--enable-usb

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/bluez.compile:
#	@$(call targetinfo)
#	cd $(BLUEZ_DIR) && $(BLUEZ_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/bluez.install:
#	@$(call targetinfo)
#	@$(call install, BLUEZ)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

BLUEZ_LIB = /usr/lib/libbluetooth.so

$(STATEDIR)/bluez.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  bluez)
	@$(call install_fixup, bluez,PACKAGE,bluez)
	@$(call install_fixup, bluez,PRIORITY,optional)
	@$(call install_fixup, bluez,VERSION,$(BLUEZ_VERSION))
	@$(call install_fixup, bluez,SECTION,base)
	@$(call install_fixup, bluez,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, bluez,DEPENDS,)
	@$(call install_fixup, bluez,DESCRIPTION,missing)
	@$(call install_copy, bluez, 0, 0, 0644, -, $(BLUEZ_LIB).3.10.5);
	@$(call install_link, bluez, libbluetooth.so.3.10.5, $(BLUEZ_LIB).3)
	@$(call install_link, bluez, libbluetooth.so.3.10.5, $(BLUEZ_LIB));
	@$(foreach pgm, hcitool l2ping rfcomm sdptool pand, \
		$(call install_copy, bluez, 0, 0, 0755, -, /usr/bin/$(pgm)); \
	)
	@$(foreach pgm, bccmd bluetoothd hciattach hciconfig, \
		$(call install_copy, bluez, 0, 0, 0755, -, /usr/sbin/$(pgm)); \
	)
	@$(foreach cfg, $(shell cd $(BLUEZ_PKGDIR); find etc -type f), \
		$(call install_copy, bluez, 0, 0, 0644, -, /$(cfg)); \
	)

	@$(call install_finish, bluez)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bluez_clean:
	rm -rf $(STATEDIR)/bluez.*
	rm -rf $(PKGDIR)/bluez_*
	rm -rf $(BLUEZ_DIR)


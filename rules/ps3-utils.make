# -*-makefile-*-
#
# Copyright (C) 2009 by Remy Bohmer <linux@bohmer.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_PPC)-$(PTXCONF_PS3_UTILS) += ps3-utils

#
# Paths and names
#
PS3_UTILS_VERSION	:= 2.3
PS3_UTILS_LICENSE	:= GPLv2
PS3_UTILS		:= ps3-utils-$(PS3_UTILS_VERSION)
PS3_UTILS_SUFFIX	:= tar.gz
PS3_UTILS_URL		:= http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-utils/$(PS3_UTILS).$(PS3_UTILS_SUFFIX)
PS3_UTILS_SOURCE	:= $(SRCDIR)/$(PS3_UTILS).$(PS3_UTILS_SUFFIX)
PS3_UTILS_DIR		:= $(BUILDDIR)/$(PS3_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PS3_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, PS3_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PS3_UTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ps3-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ps3-utils)
	@$(call install_fixup, ps3-utils,PACKAGE,ps3-utils)
	@$(call install_fixup, ps3-utils,PRIORITY,optional)
	@$(call install_fixup, ps3-utils,VERSION,$(PS3_UTILS_VERSION))
	@$(call install_fixup, ps3-utils,SECTION,base)
	@$(call install_fixup, ps3-utils,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, ps3-utils,DEPENDS,)
	@$(call install_fixup, ps3-utils,DESCRIPTION,missing)

	@$(call install_copy, ps3-utils, 0, 0, 0644, -, /usr/lib/libps3-utils.so.2.0.0)
	@$(call install_link, ps3-utils, libps3-utils.so.2.0.0, /usr/lib/libps3-utils.so)
	@$(call install_link, ps3-utils, libps3-utils.so.2.0.0, /usr/lib/libps3-utils.so.2)

	@$(call install_copy, ps3-utils, 0, 0, 0755, -, /usr/bin/ps3-video-mode)
	@$(call install_copy, ps3-utils, 0, 0, 0755, -, /usr/sbin/ps3-boot-game-os)
	@$(call install_copy, ps3-utils, 0, 0, 0755, -, /usr/sbin/ps3-dump-bootloader)
	@$(call install_copy, ps3-utils, 0, 0, 0755, -, /usr/sbin/ps3-flash-util)
	@$(call install_copy, ps3-utils, 0, 0, 0755, -, /usr/sbin/ps3-rtc-init)

	@$(call install_finish, ps3-utils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ps3-utils_clean:
	rm -rf $(STATEDIR)/ps3-utils.*
	rm -rf $(PKGDIR)/ps3-utils_*
	rm -rf $(PS3_UTILS_DIR)

# vim: syntax=make

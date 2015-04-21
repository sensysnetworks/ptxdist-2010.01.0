# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_WINDOWSWM) += xorg-lib-windowswm

#
# Paths and names
#
XORG_LIB_WINDOWSWM_VERSION	:= 1.0.1
XORG_LIB_WINDOWSWM		:= libWindowsWM-$(XORG_LIB_WINDOWSWM_VERSION)
XORG_LIB_WINDOWSWM_SUFFIX	:= tar.bz2
XORG_LIB_WINDOWSWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_DIR		:= $(BUILDDIR)/$(XORG_LIB_WINDOWSWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_WINDOWSWM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_WINDOWSWM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_WINDOWSWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_WINDOWSWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_WINDOWSWM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-windowswm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-windowswm)
	@$(call install_fixup, xorg-lib-windowswm,PACKAGE,xorg-lib-windowswm)
	@$(call install_fixup, xorg-lib-windowswm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-windowswm,VERSION,$(XORG_LIB_WINDOWSWM_VERSION))
	@$(call install_fixup, xorg-lib-windowswm,SECTION,base)
	@$(call install_fixup, xorg-lib-windowswm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-windowswm,DEPENDS,)
	@$(call install_fixup, xorg-lib-windowswm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-windowswm, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libWindowsWM.so.7.0.0)

	@$(call install_link, xorg-lib-windowswm, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so.7)

	@$(call install_link, xorg-lib-windowswm, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so)

	@$(call install_finish, xorg-lib-windowswm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-windowswm_clean:
	rm -rf $(STATEDIR)/xorg-lib-windowswm.*
	rm -rf $(PKGDIR)/xorg-lib-windowswm_*
	rm -rf $(XORG_LIB_WINDOWSWM_DIR)

# vim: syntax=make

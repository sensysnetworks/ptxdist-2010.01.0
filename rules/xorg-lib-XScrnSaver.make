# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XSCRNSAVER) += xorg-lib-xscrnsaver

#
# Paths and names
#
XORG_LIB_XSCRNSAVER_VERSION	:= 1.2.0
XORG_LIB_XSCRNSAVER		:= libXScrnSaver-$(XORG_LIB_XSCRNSAVER_VERSION)
XORG_LIB_XSCRNSAVER_SUFFIX	:= tar.bz2
XORG_LIB_XSCRNSAVER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XSCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XSCRNSAVER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XSCRNSAVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XSCRNSAVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XSCRNSAVER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XSCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xscrnsaver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PACKAGE,xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xscrnsaver,VERSION,$(XORG_LIB_XSCRNSAVER_VERSION))
	@$(call install_fixup, xorg-lib-xscrnsaver,SECTION,base)
	@$(call install_fixup, xorg-lib-xscrnsaver,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xscrnsaver,DEPENDS,)
	@$(call install_fixup, xorg-lib-xscrnsaver,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xscrnsaver, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXss.so.1.0.0)

	@$(call install_link, xorg-lib-xscrnsaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so.1)

	@$(call install_link, xorg-lib-xscrnsaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so)

	@$(call install_finish, xorg-lib-xscrnsaver)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_clean:
	rm -rf $(STATEDIR)/xorg-lib-xscrnsaver.*
	rm -rf $(PKGDIR)/xorg-lib-xscrnsaver_*
	rm -rf $(XORG_LIB_XSCRNSAVER_DIR)

# vim: syntax=make

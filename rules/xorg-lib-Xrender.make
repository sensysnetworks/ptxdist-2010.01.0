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
PACKAGES-$(PTXCONF_XORG_LIB_XRENDER) += xorg-lib-xrender

#
# Paths and names
#
XORG_LIB_XRENDER_VERSION	:= 0.9.5
XORG_LIB_XRENDER		:= libXrender-$(XORG_LIB_XRENDER_VERSION)
XORG_LIB_XRENDER_SUFFIX		:= tar.bz2
XORG_LIB_XRENDER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XRENDER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XRENDER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XRENDER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XRENDER_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XRENDER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRENDER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xrender.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-xrender,PACKAGE,xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-xrender,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xrender,VERSION,$(XORG_LIB_XRENDER_VERSION))
	@$(call install_fixup, xorg-lib-xrender,SECTION,base)
	@$(call install_fixup, xorg-lib-xrender,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xrender,DEPENDS,)
	@$(call install_fixup, xorg-lib-xrender,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xrender, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXrender.so.1.3.0)

	@$(call install_link, xorg-lib-xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so.1)

	@$(call install_link, xorg-lib-xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so)

	@$(call install_finish, xorg-lib-xrender)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xrender_clean:
	rm -rf $(STATEDIR)/xorg-lib-xrender.*
	rm -rf $(PKGDIR)/xorg-lib-xrender_*
	rm -rf $(XORG_LIB_XRENDER_DIR)

# vim: syntax=make

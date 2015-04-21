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
PACKAGES-$(PTXCONF_XORG_LIB_XRES) += xorg-lib-xres

#
# Paths and names
#
XORG_LIB_XRES_VERSION	:= 1.0.4
XORG_LIB_XRES		:= libXres-$(XORG_LIB_XRES_VERSION)
XORG_LIB_XRES_SUFFIX	:= tar.bz2
XORG_LIB_XRES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XRES_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XRES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XRES_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XRES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRES_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XRES_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xres.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PACKAGE,xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xres,VERSION,$(XORG_LIB_XRES_VERSION))
	@$(call install_fixup, xorg-lib-xres,SECTION,base)
	@$(call install_fixup, xorg-lib-xres,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xres,DEPENDS,)
	@$(call install_fixup, xorg-lib-xres,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xres, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXRes.so.1.0.0)

	@$(call install_link, xorg-lib-xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so.1)

	@$(call install_link, xorg-lib-xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so)

	@$(call install_finish, xorg-lib-xres)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xres_clean:
	rm -rf $(STATEDIR)/xorg-lib-xres.*
	rm -rf $(PKGDIR)/xorg-lib-xres_*
	rm -rf $(XORG_LIB_XRES_DIR)

# vim: syntax=make

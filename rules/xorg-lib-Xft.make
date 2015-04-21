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
PACKAGES-$(PTXCONF_XORG_LIB_XFT) += xorg-lib-xft

#
# Paths and names
#
XORG_LIB_XFT_VERSION	:= 2.1.14
XORG_LIB_XFT		:= libXft-$(XORG_LIB_XFT_VERSION)
XORG_LIB_XFT_SUFFIX	:= tar.bz2
XORG_LIB_XFT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX)
XORG_LIB_XFT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX)
XORG_LIB_XFT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XFT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XFT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XFT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xft.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xft)
	@$(call install_fixup, xorg-lib-xft,PACKAGE,xorg-lib-xft)
	@$(call install_fixup, xorg-lib-xft,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xft,VERSION,$(XORG_LIB_XFT_VERSION))
	@$(call install_fixup, xorg-lib-xft,SECTION,base)
	@$(call install_fixup, xorg-lib-xft,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xft,DEPENDS,)
	@$(call install_fixup, xorg-lib-xft,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xft, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXft.so.2.1.13)

	@$(call install_link, xorg-lib-xft, \
		libXft.so.2.1.13, \
		$(XORG_LIBDIR)/libXft.so.2)

	@$(call install_link, xorg-lib-xft, \
		libXft.so.2.1.13, \
		$(XORG_LIBDIR)/libXft.so)

	@$(call install_finish, xorg-lib-xft)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xft_clean:
	rm -rf $(STATEDIR)/xorg-lib-xft.*
	rm -rf $(PKGDIR)/xorg-lib-xft_*
	rm -rf $(XORG_LIB_XFT_DIR)

# vim: syntax=make

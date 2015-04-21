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
PACKAGES-$(PTXCONF_XORG_LIB_XAU) += xorg-lib-xau

#
# Paths and names
#
XORG_LIB_XAU_VERSION	:= 1.0.5
XORG_LIB_XAU		:= libXau-$(XORG_LIB_XAU_VERSION)
XORG_LIB_XAU_SUFFIX	:= tar.bz2
XORG_LIB_XAU_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XAU_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XAU_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XAU_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XAU_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

ifdef PTXCONF_XORG_LIB_XAU_THREAD
XORG_LIB_XAU_AUTOCONF += --enable-xthreads
else
XORG_LIB_XAU_AUTOCONF += --disable-xthreads
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xau.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xau)
	@$(call install_fixup, xorg-lib-xau,PACKAGE,xorg-lib-xau)
	@$(call install_fixup, xorg-lib-xau,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xau,VERSION,$(XORG_LIB_XAU_VERSION))
	@$(call install_fixup, xorg-lib-xau,SECTION,base)
	@$(call install_fixup, xorg-lib-xau,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xau,DEPENDS,)
	@$(call install_fixup, xorg-lib-xau,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xau, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXau.so.6.0.0)

	@$(call install_link, xorg-lib-xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so.6)

	@$(call install_link, xorg-lib-xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so)

	@$(call install_finish, xorg-lib-xau)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xau_clean:
	rm -rf $(STATEDIR)/xorg-lib-xau.*
	rm -rf $(PKGDIR)/xorg-lib-xau_*
	rm -rf $(XORG_LIB_XAU_DIR)

# vim: syntax=make

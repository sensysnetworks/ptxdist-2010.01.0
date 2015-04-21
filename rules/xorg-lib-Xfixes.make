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
PACKAGES-$(PTXCONF_XORG_LIB_XFIXES) += xorg-lib-xfixes

#
# Paths and names
#
XORG_LIB_XFIXES_VERSION	:= 4.0.4
XORG_LIB_XFIXES		:= libXfixes-$(XORG_LIB_XFIXES_VERSION)
XORG_LIB_XFIXES_SUFFIX	:= tar.bz2
XORG_LIB_XFIXES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX)
XORG_LIB_XFIXES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX)
XORG_LIB_XFIXES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFIXES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XFIXES_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XFIXES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XFIXES_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XFIXES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFIXES_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xfixes.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xfixes)
	@$(call install_fixup, xorg-lib-xfixes,PACKAGE,xorg-lib-xfixes)
	@$(call install_fixup, xorg-lib-xfixes,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfixes,VERSION,$(XORG_LIB_XFIXES_VERSION))
	@$(call install_fixup, xorg-lib-xfixes,SECTION,base)
	@$(call install_fixup, xorg-lib-xfixes,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfixes,DEPENDS,)
	@$(call install_fixup, xorg-lib-xfixes,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xfixes, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXfixes.so.3.1.0)

	@$(call install_link, xorg-lib-xfixes, \
		libXfixes.so.3.1.0, \
		$(XORG_LIBDIR)/libXfixes.so.3)

	@$(call install_link, xorg-lib-xfixes, \
		libXfixes.so.3.1.0, \
		$(XORG_LIBDIR)/libXfixes.so)

	@$(call install_finish, xorg-lib-xfixes)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xfixes_clean:
	rm -rf $(STATEDIR)/xorg-lib-xfixes.*
	rm -rf $(PKGDIR)/xorg-lib-xfixes_*
	rm -rf $(XORG_LIB_XFIXES_DIR)

# vim: syntax=make

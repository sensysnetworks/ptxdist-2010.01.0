# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFFI) += libffi

#
# Paths and names
#
LIBFFI_VERSION	:= 3.0.8
LIBFFI		:= libffi-$(LIBFFI_VERSION)
LIBFFI_SUFFIX	:= tar.gz
LIBFFI_SOURCE	:= $(SRCDIR)/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_DIR	:= $(BUILDDIR)/$(LIBFFI)

LIBFFI_URL	:= \
	http://ftp.gwdg.de/pub/linux/sources.redhat.com/libffi/$(LIBFFI).$(LIBFFI_SUFFIX) \
	ftp://sourceware.org/pub/libffi/$(LIBFFI).$(LIBFFI_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBFFI_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBFFI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFFI_PATH	:= PATH=$(CROSS_PATH)
LIBFFI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBFFI_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.install:
	@$(call targetinfo)
	@$(call install, LIBFFI)
	mv "$(SYSROOT)/usr/lib/$(LIBFFI)/include/"* "$(SYSROOT)/usr/include"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libffi)
	@$(call install_fixup, libffi,PACKAGE,libffi)
	@$(call install_fixup, libffi,PRIORITY,optional)
	@$(call install_fixup, libffi,VERSION,$(LIBFFI_VERSION))
	@$(call install_fixup, libffi,SECTION,base)
	@$(call install_fixup, libffi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libffi,DEPENDS,)
	@$(call install_fixup, libffi,DESCRIPTION,missing)

	@$(call install_copy, libffi, 0, 0, 0644, -, \
		/usr/lib/libffi.so.5.0.9)
	@$(call install_link, libffi, libffi.so.5.0.9, /usr/lib/libffi.so.5)
	@$(call install_link, libffi, libffi.so.5.0.9, /usr/lib/libffi.so)

	@$(call install_finish, libffi)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libffi_clean:
	rm -rf $(STATEDIR)/libffi.*
	rm -rf $(PKGDIR)/libffi_*
	rm -rf $(LIBFFI_DIR)

# vim: syntax=make

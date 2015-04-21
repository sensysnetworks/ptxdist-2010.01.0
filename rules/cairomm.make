# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
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
PACKAGES-$(PTXCONF_CAIROMM) += cairomm

#
# Paths and names
#
CAIROMM_VERSION	:= 1.8.0
CAIROMM		:= cairomm-$(CAIROMM_VERSION)
CAIROMM_SUFFIX	:= tar.gz
CAIROMM_URL	:= http://cairographics.org/releases/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_SOURCE	:= $(SRCDIR)/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_DIR	:= $(BUILDDIR)/$(CAIROMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CAIROMM_SOURCE):
	@$(call targetinfo)
	@$(call get, CAIROMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CAIROMM_PATH	:= PATH=$(CROSS_PATH)
CAIROMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIROMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cairomm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cairomm)
	@$(call install_fixup, cairomm,PACKAGE,cairomm)
	@$(call install_fixup, cairomm,PRIORITY,optional)
	@$(call install_fixup, cairomm,VERSION,$(CAIROMM_VERSION))
	@$(call install_fixup, cairomm,SECTION,base)
	@$(call install_fixup, cairomm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, cairomm,DEPENDS,)
	@$(call install_fixup, cairomm,DESCRIPTION,missing)

	@$(call install_copy, cairomm, 0, 0, 0644, -, /usr/lib/libcairomm-1.0.so.1.3.0)

	@$(call install_link, cairomm, \
		libcairomm-1.0.so.1.3.0, /usr/lib/libcairomm-1.0.so.1)

	@$(call install_link, cairomm, \
		libcairomm-1.0.so.1.3.0, /usr/lib/libcairomm-1.0.so)

	@$(call install_finish, cairomm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cairomm_clean:
	rm -rf $(STATEDIR)/cairomm.*
	rm -rf $(PKGDIR)/cairomm_*
	rm -rf $(CAIROMM_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGOMM) += pangomm

#
# Paths and names
#
PANGOMM_VERSION	:= 2.26.0
PANGOMM		:= pangomm-$(PANGOMM_VERSION)
PANGOMM_SUFFIX	:= tar.bz2
PANGOMM_URL	:= http://ftp.acc.umu.se/pub/GNOME/sources/pangomm/2.26/$(PANGOMM).$(PANGOMM_SUFFIX)
PANGOMM_SOURCE	:= $(SRCDIR)/$(PANGOMM).$(PANGOMM_SUFFIX)
PANGOMM_DIR	:= $(BUILDDIR)/$(PANGOMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PANGOMM_SOURCE):
	@$(call targetinfo)
	@$(call get, PANGOMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PANGOMM_PATH	:= PATH=$(CROSS_PATH)
PANGOMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PANGOMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pangomm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pangomm)
	@$(call install_fixup, pangomm,PACKAGE,pangomm)
	@$(call install_fixup, pangomm,PRIORITY,optional)
	@$(call install_fixup, pangomm,VERSION,$(PANGOMM_VERSION))
	@$(call install_fixup, pangomm,SECTION,base)
	@$(call install_fixup, pangomm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pangomm,DEPENDS,)
	@$(call install_fixup, pangomm,DESCRIPTION,missing)

	@$(call install_copy, pangomm, 0, 0, 0644, -, /usr/lib/libpangomm-1.4.so.1.0.30)
	@$(call install_link, pangomm, libpangomm-1.4.so.1.0.30, /usr/lib/libpangomm-1.4.so.1)
	@$(call install_link, pangomm, libpangomm-1.4.so.1.0.30, /usr/lib/libpangomm-1.4.so)

	@$(call install_finish, pangomm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pangomm_clean:
	rm -rf $(STATEDIR)/pangomm.*
	rm -rf $(PKGDIR)/pangomm_*
	rm -rf $(PANGOMM_DIR)

# vim: syntax=make

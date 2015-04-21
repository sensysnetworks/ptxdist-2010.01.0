# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HTOP) += htop

#
# Paths and names
#
HTOP_VERSION	:= 0.8.1
HTOP		:= htop-$(HTOP_VERSION)
HTOP_SUFFIX	:= tar.gz
HTOP_URL	:= $(PTXCONF_SETUP_SFMIRROR)/htop/$(HTOP).$(HTOP_SUFFIX)
HTOP_SOURCE	:= $(SRCDIR)/$(HTOP).$(HTOP_SUFFIX)
HTOP_DIR	:= $(BUILDDIR)/$(HTOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HTOP_SOURCE):
	@$(call targetinfo)
	@$(call get, HTOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HTOP_PATH	:= PATH=$(CROSS_PATH)
HTOP_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes

#
# autoconf
#
HTOP_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/htop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, htop)
	@$(call install_fixup, htop,PACKAGE,htop)
	@$(call install_fixup, htop,PRIORITY,optional)
	@$(call install_fixup, htop,VERSION,$(HTOP_VERSION))
	@$(call install_fixup, htop,SECTION,base)
	@$(call install_fixup, htop,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, htop,DEPENDS,)
	@$(call install_fixup, htop,DESCRIPTION,missing)

	@$(call install_copy, htop, 0, 0, 0755, -, /usr/bin/htop)

	@$(call install_finish, htop)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

htop_clean:
	rm -rf $(STATEDIR)/htop.*
	rm -rf $(PKGDIR)/htop_*
	rm -rf $(HTOP_DIR)

# vim: syntax=make

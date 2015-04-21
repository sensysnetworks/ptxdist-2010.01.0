# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Wolfram Sang
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PV) += pv

#
# Paths and names
#
PV_VERSION	:= 1.1.4
PV		:= pv-$(PV_VERSION)
PV_SUFFIX	:= tar.bz2
PV_URL		:= http://pipeviewer.googlecode.com/files/$(PV).$(PV_SUFFIX)
PV_SOURCE	:= $(SRCDIR)/$(PV).$(PV_SUFFIX)
PV_DIR		:= $(BUILDDIR)/$(PV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PV_SOURCE):
	@$(call targetinfo)
	@$(call get, PV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PV_PATH	:= PATH=$(CROSS_PATH)
PV_ENV 	:= $(CROSS_ENV)
PV_MAKEVARS := $(CROSS_ENV_LD)

#
# autoconf
#
PV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--enable-debugging

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pv)
	@$(call install_fixup, pv,PACKAGE,pv)
	@$(call install_fixup, pv,PRIORITY,optional)
	@$(call install_fixup, pv,VERSION,$(PV_VERSION))
	@$(call install_fixup, pv,SECTION,base)
	@$(call install_fixup, pv,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, pv,DEPENDS,)
	@$(call install_fixup, pv,DESCRIPTION,missing)

	@$(call install_copy, pv, 0, 0, 0755, -, /usr/bin/pv)

	@$(call install_finish, pv)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pv_clean:
	rm -rf $(STATEDIR)/pv.*
	rm -rf $(PKGDIR)/pv_*
	rm -rf $(PV_DIR)

# vim: syntax=make

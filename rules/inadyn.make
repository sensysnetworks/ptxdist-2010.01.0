# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Juergen Beisert
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
PACKAGES-$(PTXCONF_INADYN) += inadyn

#
# Paths and names
#
INADYN_VERSION	:= 1.96.2
INADYN		:= inadyn-$(INADYN_VERSION)
INADYN_SUFFIX	:= tar.bz2
INADYN_URL	:= http://cdn.dyndns.com/$(INADYN).$(INADYN_SUFFIX)
INADYN_SOURCE	:= $(SRCDIR)/$(INADYN).$(INADYN_SUFFIX)
INADYN_DIR	:= $(BUILDDIR)/$(INADYN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INADYN_SOURCE):
	@$(call targetinfo)
	@$(call get, INADYN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.extract:
	@$(call targetinfo)
	@$(call clean, $(INADYN_DIR))
	@$(call extract, INADYN)
	mv $(BUILDDIR)/inadyn $(INADYN_DIR)
	@$(call patchin, INADYN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

INADYN_PATH	:= PATH=$(CROSS_PATH)
INADYN_ENV	:= $(CROSS_ENV)

$(STATEDIR)/inadyn.compile:
	@$(call targetinfo)
	cd $(INADYN_DIR) && $(INADYN_PATH) $(INADYN_ENV) $(MAKE) \
		$(INADYN_MAKE) TARGET_ARCH=linux $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inadyn)
	@$(call install_fixup, inadyn,PACKAGE,inadyn)
	@$(call install_fixup, inadyn,PRIORITY,optional)
	@$(call install_fixup, inadyn,VERSION,$(INADYN_VERSION))
	@$(call install_fixup, inadyn,SECTION,base)
	@$(call install_fixup, inadyn,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, inadyn,DEPENDS,)
	@$(call install_fixup, inadyn,DESCRIPTION,missing)

	@$(call install_copy, inadyn, 0, 0, 0755, \
		$(INADYN_DIR)/bin/linux/inadyn, /sbin/inadyn)

	@$(call install_alternative, inadyn, 0, 0, 0600, /etc/inadyn.conf)

	@$(call install_finish, inadyn)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inadyn_clean:
	rm -rf $(STATEDIR)/inadyn.*
	rm -rf $(PKGDIR)/inadyn_*
	rm -rf $(INADYN_DIR)

# vim: syntax=make

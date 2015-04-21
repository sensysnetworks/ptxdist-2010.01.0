# -*-makefile-*-
# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMSTAT) += memstat

#
# Paths and names
#
MEMSTAT_VERSION	:= 0.8
MEMSTAT		:= memstat_$(MEMSTAT_VERSION)
MEMSTAT_SUFFIX	:= tar.gz
MEMSTAT_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/memstat/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX)
MEMSTAT_SOURCE	:= $(SRCDIR)/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX)
MEMSTAT_DIR	:= $(BUILDDIR)/memstat-$(MEMSTAT_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MEMSTAT_SOURCE):
	@$(call targetinfo)
	@$(call get, MEMSTAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMSTAT_PATH	:= PATH=$(CROSS_PATH)
MEMSTAT_ENV	:= $(CROSS_ENV)

MEMSTAT_MAKEVARS := $(CROSS_ENV_CC) DEB_BUILD_OPTIONS=debug,nostrip

$(STATEDIR)/memstat.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memstat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memstat)
	@$(call install_fixup, memstat,PACKAGE,memstat)
	@$(call install_fixup, memstat,PRIORITY,optional)
	@$(call install_fixup, memstat,VERSION,$(MEMSTAT_VERSION))
	@$(call install_fixup, memstat,SECTION,base)
	@$(call install_fixup, memstat,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, memstat,DEPENDS,)
	@$(call install_fixup, memstat,DESCRIPTION,missing)

	@$(call install_copy, memstat, 0, 0, 0644, -, /etc/memstat.conf, n)
	@$(call install_copy, memstat, 0, 0, 0755, -, /usr/bin/memstat)

	@$(call install_finish, memstat)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memstat_clean:
	rm -rf $(STATEDIR)/memstat.*
	rm -rf $(PKGDIR)/memstat_*
	rm -rf $(MEMSTAT_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XERCES) += xerces

#
# Paths and names
#
XERCES_VERSION	:= 2_7_0
XERCES		:= xerces-c-src_$(XERCES_VERSION)
XERCES_SUFFIX	:= tar.gz
XERCES_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XERCES).$(XERCES_SUFFIX)
XERCES_SOURCE	:= $(SRCDIR)/$(XERCES).$(XERCES_SUFFIX)
XERCES_DIR	:= $(BUILDDIR)/$(XERCES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XERCES_SOURCE):
	@$(call targetinfo)
	@$(call get, XERCES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XERCES_PATH	:= PATH=$(CROSS_PATH)
XERCES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XERCES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xerces.prepare:
	@$(call targetinfo)
	@$(call clean, $(XERCES_DIR)/config.cache)
	cd $(XERCES_DIR)/src/xercesc && \
		$(XERCES_PATH) $(XERCES_ENV) \
		./configure $(XERCES_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xerces.compile:
	@$(call targetinfo)
	export XERCESCROOT=$(XERCES_DIR); \
		cd $(XERCES_DIR)/src/xercesc && $(XERCES_PATH) SYSROOT=$(SYSROOT) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xerces.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xerces.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xerces)
	@$(call install_fixup, xerces,PACKAGE,xerces)
	@$(call install_fixup, xerces,PRIORITY,optional)
	@$(call install_fixup, xerces,VERSION,$(XERCES_VERSION))
	@$(call install_fixup, xerces,SECTION,base)
	@$(call install_fixup, xerces,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xerces,DEPENDS,)
	@$(call install_fixup, xerces,DESCRIPTION,missing)

	@$(call install_copy, xerces, 0, 0, 0644, \
		$(XERCES_DIR)/lib/libxerces-c.so.27.0, \
		/usr/lib/libxerces-c.so.27.0)

	@$(call install_link, xerces, libxerces-c.so.27.0, /usr/lib/libxerces-c.so.27)
	@$(call install_link, xerces, libxerces-c.so.27, /usr/lib/libxerces-c.so)

	@$(call install_finish, xerces)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xerces_clean:
	rm -rf $(STATEDIR)/xerces.*
	rm -rf $(PKGDIR)/xerces_*
	rm -rf $(XERCES_DIR)

# vim: syntax=make

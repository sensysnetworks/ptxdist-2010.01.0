# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MBW) += mbw

#
# Paths and names
#
MBW_VERSION	:= 1.1-1
MBW		:= mbw-$(MBW_VERSION)
MBW_SUFFIX	:= tar.gz
MBW_URL		:= http://ahorvath.web.cern.ch/ahorvath/mbw/$(MBW).$(MBW_SUFFIX)
MBW_SOURCE	:= $(SRCDIR)/$(MBW).$(MBW_SUFFIX)
MBW_DIR		:= $(BUILDDIR)/$(MBW)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MBW_SOURCE):
	@$(call targetinfo)
	@$(call get, MBW)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.extract:
	@$(call targetinfo)
	@$(call clean, $(MBW_DIR))
	@$(call extract, MBW)
	# we have a crappy name
	mv $(BUILDDIR)/mbw $(MBW_DIR)
	@$(call patchin, MBW)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MBW_PATH	:= PATH=$(CROSS_PATH)
MBW_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/mbw.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.compile:
	@$(call targetinfo)
	cd $(MBW_DIR) && $(MBW_PATH) $(MAKE) CC=$(CROSS_CC) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mbw)
	@$(call install_fixup, mbw,PACKAGE,mbw)
	@$(call install_fixup, mbw,PRIORITY,optional)
	@$(call install_fixup, mbw,VERSION,$(MBW_VERSION))
	@$(call install_fixup, mbw,SECTION,base)
	@$(call install_fixup, mbw,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mbw,DEPENDS,)
	@$(call install_fixup, mbw,DESCRIPTION,missing)

	@$(call install_copy, mbw, 0, 0, 0755, $(MBW_DIR)/mbw, /usr/bin/mbw)

	@$(call install_finish, mbw)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mbw_clean:
	rm -rf $(STATEDIR)/mbw.*
	rm -rf $(PKGDIR)/mbw_*
	rm -rf $(MBW_DIR)

# vim: syntax=make

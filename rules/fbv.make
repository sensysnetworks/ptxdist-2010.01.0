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
PACKAGES-$(PTXCONF_FBV) += fbv

#
# Paths and names
#
FBV_VERSION	:= 1.0b-ptx3
FBV		:= fbv-$(FBV_VERSION)
FBV_SUFFIX	:= tar.bz2
FBV_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBV).$(FBV_SUFFIX)
#FBV_URL	:= http://s-tech.elsat.net.pl/fbv/$(FBV).$(FBV_SUFFIX)
FBV_SOURCE	:= $(SRCDIR)/$(FBV).$(FBV_SUFFIX)
FBV_DIR		:= $(BUILDDIR)/$(FBV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FBV_SOURCE):
	@$(call targetinfo)
	@$(call get, FBV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.extract:
	@$(call targetinfo)
	@$(call clean, $(FBV_DIR))
	@$(call extract, FBV)
	@$(call patchin, FBV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FBV_PATH	:= PATH=$(CROSS_PATH)
FBV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FBV_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/fbv.prepare:
	@$(call targetinfo)
	@$(call clean, $(FBV_DIR)/config.cache)
	cd $(FBV_DIR) && \
		$(FBV_PATH) $(FBV_ENV) \
		./configure $(FBV_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.compile:
	@$(call targetinfo)
	cd $(FBV_DIR) && $(FBV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.install:
	@$(call targetinfo)
	@$(call install, FBV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbv)
	@$(call install_fixup, fbv,PACKAGE,fbv)
	@$(call install_fixup, fbv,PRIORITY,optional)
	@$(call install_fixup, fbv,VERSION,$(FBV_VERSION))
	@$(call install_fixup, fbv,SECTION,base)
	@$(call install_fixup, fbv,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbv,DEPENDS,)
	@$(call install_fixup, fbv,DESCRIPTION,missing)

	@$(call install_copy, fbv, 0, 0, 0755, -, /usr/bin/fbv)

	@$(call install_finish, fbv)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbv_clean:
	rm -rf $(STATEDIR)/fbv.*
	rm -rf $(PKGDIR)/fbv_*
	rm -rf $(FBV_DIR)

# vim: syntax=make

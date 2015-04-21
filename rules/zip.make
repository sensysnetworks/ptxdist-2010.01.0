# -*-makefile-*-
#
# Copyright (C) 2007 by Ladislav Michl
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZIP) += zip

#
# Paths and names
# (zip is packaged a bit unusual way, that's why two version variables exist)
#
ZIP_VERSION	:= 3.0
ZIP_AVERSION	:= 30
ZIP_ARCHIVE	:= zip$(ZIP_AVERSION).tar.gz
ZIP		:= zip$(ZIP_AVERSION)
ZIP_URL		:= http://surfnet.dl.sourceforge.net/sourceforge/infozip/$(ZIP_ARCHIVE)
ZIP_SOURCE	:= $(SRCDIR)/$(ZIP_ARCHIVE)
ZIP_DIR		:= $(BUILDDIR)/$(ZIP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ZIP_SOURCE):
	@$(call targetinfo)
	@$(call get, ZIP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ZIP_PATH	:= PATH=$(CROSS_PATH)
ZIP_MAKEVARS	:= $(CROSS_ENV_CC) $(CROSS_ENV_CPP) $(CROSS_ENV_AS)

$(STATEDIR)/zip.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/zip.compile:
	@$(call targetinfo)
	cd $(ZIP_DIR) && $(ZIP_PATH) \
		$(MAKE) $(PARALLELMFLAGS) $(ZIP_MAKEVARS) -f unix/Makefile generic
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zip.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, zip)
	@$(call install_fixup, zip,PACKAGE,zip)
	@$(call install_fixup, zip,PRIORITY,optional)
	@$(call install_fixup, zip,VERSION,$(ZIP_VERSION))
	@$(call install_fixup, zip,SECTION,base)
	@$(call install_fixup, zip,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, zip,DEPENDS,)
	@$(call install_fixup, zip,DESCRIPTION,missing)

ifdef PTXCONF_ZIP_ZIP
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zip, /usr/bin/zip)
endif
ifdef PTXCONF_ZIP_ZIPCLOAK
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipcloak, /usr/bin/zipcloak)
endif
ifdef PTXCONF_ZIP_ZIPNOTE
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipnote, /usr/bin/zipnote)
endif
ifdef PTXCONF_ZIP_ZIPSPLIT
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipsplit, /usr/bin/zipsplit)
endif

	@$(call install_finish, zip)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zip_clean:
	rm -rf $(STATEDIR)/zip.*
	rm -rf $(PKGDIR)/zip_*
	rm -rf $(ZIP_DIR)

# vim: syntax=make

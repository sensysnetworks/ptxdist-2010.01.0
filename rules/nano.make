# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NANO) += nano

#
# Paths and names
#
NANO_VERSION		= 1.3.10
NANO			= nano-$(NANO_VERSION)
NANO_SUFFIX		= tar.gz
NANO_URL		= http://www.nano-editor.org/dist/v1.3/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		= $(BUILDDIR)/$(NANO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NANO_SOURCE):
	@$(call targetinfo)
	@$(call get, NANO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NANO_PATH	=  PATH=$(CROSS_PATH)
NANO_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
NANO_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nano.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nano)
	@$(call install_fixup,nano,PACKAGE,nano)
	@$(call install_fixup,nano,PRIORITY,optional)
	@$(call install_fixup,nano,VERSION,$(NANO_VERSION))
	@$(call install_fixup,nano,SECTION,base)
	@$(call install_fixup,nano,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,nano,DEPENDS,)
	@$(call install_fixup,nano,DESCRIPTION,missing)

	@$(call install_copy, nano, 0, 0, 0755, -, /usr/bin/nano)
	@$(call install_finish,nano)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nano_clean:
	rm -rf $(STATEDIR)/nano.*
	rm -rf $(NANO_DIR)

# vim: syntax=make

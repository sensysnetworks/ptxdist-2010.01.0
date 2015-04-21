# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
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
PACKAGES-$(PTXCONF_BONNIEXX) += bonniexx

#
# Paths and names
#
BONNIEXX_VERSION	:= 1.03e
BONNIEXX		:= bonnie++-$(BONNIEXX_VERSION)
BONNIEXX_SUFFIX		:= tgz
BONNIEXX_URL		:= http://www.coker.com.au/bonnie++/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_SOURCE		:= $(SRCDIR)/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_DIR		:= $(BUILDDIR)/$(BONNIEXX)
BONNIEXX_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BONNIEXX_SOURCE):
	@$(call targetinfo)
	@$(call get, BONNIEXX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BONNIEXX_PATH	  := PATH=$(CROSS_PATH)
BONNIEXX_ENV 	  := $(CROSS_ENV)

#
# autoconf
#
BONNIEXX_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-stripping

BONNIEXX_MAKEVARS := prefix=$(PKGDIR)/$(BONNIEXX)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bonniexx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bonniexx)
	@$(call install_fixup, bonniexx,PACKAGE,bonniexx)
	@$(call install_fixup, bonniexx,PRIORITY,optional)
	@$(call install_fixup, bonniexx,VERSION,$(BONNIEXX_VERSION))
	@$(call install_fixup, bonniexx,SECTION,base)
	@$(call install_fixup, bonniexx,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bonniexx,DEPENDS,)
	@$(call install_fixup, bonniexx,DESCRIPTION,missing)

	@$(call install_copy, bonniexx, 0, 0, 0755, -, \
		/usr/sbin/bonnie++)

	@$(call install_finish, bonniexx)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bonniexx_clean:
	rm -rf $(STATEDIR)/bonniexx.*
	rm -rf $(PKGDIR)/bonniexx_*
	rm -rf $(BONNIEXX_DIR)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2010 by Ian Lance Taylor
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PPTP) += pptp
#
# Paths and names
#
PPTP_VERSION	:= 1.7.1
PPTP		:= pptp-$(PPTP_VERSION)
PPTP_SUFFIX		:= tar.gz
PPTP_URL		:= http://engr.sensysnetworks.net/$(PPTP).$(PPTP_SUFFIX)
PPTP_SOURCE		:= $(SRCDIR)/$(PPTP).$(PPTP_SUFFIX)
PPTP_DIR		:= $(BUILDDIR)/$(PPTP)
PPTP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PPTP_SOURCE):
	@$(call targetinfo)
	@$(call get, PPTP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PPTP_PATH	:= PATH=$(CROSS_PATH)
PPTP_ENV 	:= $(CROSS_ENV) $(CROSS_ENV_CPP) $(CROSS_ENV_AS)

$(STATEDIR)/pptp.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/pptp.compile:
	@$(call targetinfo)
	cd $(PPTP_DIR) && $(PPTP_PATH) $(MAKE) $(PARALLELMFLAGS) $(PPTP_ENV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pptp.install:
	@$(call targetinfo)
	@$(call install, PPTP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pptp.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  pptp)
	@$(call install_fixup, pptp,PACKAGE,pptp)
	@$(call install_fixup, pptp,PRIORITY,optional)
	@$(call install_fixup, pptp,VERSION,$(PPTP_VERSION))
	@$(call install_fixup, pptp,SECTION,base)
	@$(call install_fixup, pptp,AUTHOR,"Unknown")
	@$(call install_fixup, pptp,DEPENDS,)
	@$(call install_fixup, pptp,DESCRIPTION,missing)

	@$(call install_copy, pptp, 0, 0, 0755, $(PPTP_DIR)/pptp, /usr/sbin/pptp)
	@$(call install_finish, pptp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pptp_clean:
	rm -rf $(STATEDIR)/pptp.*
	rm -rf $(PKGDIR)/pptp_*
	rm -rf $(PPTP_DIR)

# vim: syntax=make

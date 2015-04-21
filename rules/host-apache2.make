# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_APACHE2) += host-apache2

#
# Paths and names
#
HOST_APACHE2		= $(APACHE2)
HOST_APACHE2_DIR	= $(HOST_BUILDDIR)/$(HOST_APACHE2)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.get: $(STATEDIR)/apache2.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_APACHE2_DIR))
	@$(call extract, APACHE2, $(HOST_BUILDDIR))
	@$(call patchin, APACHE2, $(HOST_APACHE2_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_APACHE2_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_APACHE2_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.compile:
	@$(call targetinfo)
	cd $(HOST_APACHE2_DIR)/srclib/apr-util/uri && $(HOST_APACHE2_ENV) $(MAKE)
	cd $(HOST_APACHE2_DIR)/srclib/pcre && $(HOST_APACHE2_ENV) $(MAKE) dftables
	cd $(HOST_APACHE2_DIR)/server && $(HOST_APACHE2_ENV) $(MAKE) gen_test_char
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-apache2_clean:
	rm -rf $(STATEDIR)/host-apache2.*
	rm -rf $(HOST_APACHE2_DIR)

# vim: syntax=make

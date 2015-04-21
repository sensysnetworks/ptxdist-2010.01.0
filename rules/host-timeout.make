# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TIMEOUT) += host-timeout

#
# Paths and names
#
HOST_TIMEOUT_DIR	= $(HOST_BUILDDIR)/$(TIMEOUT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.get: $(STATEDIR)/timeout.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_TIMEOUT_DIR))
	@$(call extract, TIMEOUT, $(HOST_BUILDDIR))
	@$(call patchin, TIMEOUT, $(HOST_TIMEOUT_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TIMEOUT_PATH	:= PATH=$(HOST_PATH)
HOST_TIMEOUT_ENV 	:= $(HOST_ENV)

$(STATEDIR)/host-timeout.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.compile:
	@$(call targetinfo)
	cd $(HOST_TIMEOUT_DIR)/src/misc && $(HOST_TIMEOUT_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN) ../../bin/timeout
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.install:
	@$(call targetinfo)
	$(INSTALL) -m 755 -D $(HOST_TIMEOUT_DIR)/bin/timeout $(PTXCONF_SYSROOT_HOST)/bin/timeout
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-timeout_clean:
	rm -rf $(STATEDIR)/host-timeout.*
	rm -rf $(HOST_TIMEOUT_DIR)

# vim: syntax=make

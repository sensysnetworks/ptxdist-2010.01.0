# -*-makefile-*-
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
HOST_PACKAGES-$(PTXCONF_HOST_EGGDBUS) += host-eggdbus

#
# Paths and names
#
HOST_EGGDBUS_DIR	= $(HOST_BUILDDIR)/$(EGGDBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-eggdbus.get: $(STATEDIR)/eggdbus.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-eggdbus.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_EGGDBUS_DIR))
	@$(call extract, EGGDBUS, $(HOST_BUILDDIR))
	@$(call patchin, EGGDBUS, $(HOST_EGGDBUS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_EGGDBUS_PATH	:= PATH=$(HOST_PATH)
HOST_EGGDBUS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_EGGDBUS_AUTOCONF	:= $(HOST_AUTOCONF)

#$(STATEDIR)/host-eggdbus.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(HOST_EGGDBUS_DIR)/config.cache)
#	cd $(HOST_EGGDBUS_DIR) && \
#		$(HOST_EGGDBUS_PATH) $(HOST_EGGDBUS_ENV) \
#		./configure $(HOST_EGGDBUS_AUTOCONF)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/host-eggdbus.compile:
#	@$(call targetinfo)
#	cd $(HOST_EGGDBUS_DIR) && $(HOST_EGGDBUS_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/host-eggdbus.install:
#	@$(call targetinfo)
#	@$(call install, HOST_EGGDBUS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-eggdbus_clean:
	rm -rf $(STATEDIR)/host-eggdbus.*
	rm -rf $(HOST_EGGDBUS_DIR)

# vim: syntax=make

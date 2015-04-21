# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_LIBDBUS_CXX) += host-libdbus-cxx

#
# Paths and names
#
HOST_LIBDBUS_CXX	= $(LIBDBUS_CXX)
HOST_LIBDBUS_CXX_DIR	= $(HOST_BUILDDIR)/$(HOST_LIBDBUS_CXX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libdbus-cxx.get: $(STATEDIR)/libdbus-cxx.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libdbus-cxx.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBDBUS_CXX_DIR))
	@$(call extract, LIBDBUS_CXX, $(HOST_BUILDDIR))
	@$(call patchin, LIBDBUS_CXX, $(HOST_LIBDBUS_CXX_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBDBUS_CXX_PATH	:= PATH=$(HOST_PATH)
HOST_LIBDBUS_CXX_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBDBUS_CXX_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libdbus-cxx_clean:
	rm -rf $(STATEDIR)/host-libdbus-cxx.*
	rm -rf $(HOST_LIBDBUS_CXX_DIR)

# vim: syntax=make

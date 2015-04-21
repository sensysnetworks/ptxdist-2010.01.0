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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON) += host-python

#
# Paths and names
#
HOST_PYTHON_DIR	=  $(HOST_BUILDDIR)/$(PYTHON)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python.get: $(STATEDIR)/python.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_PYTHON_DIR))
	@$(call extract, PYTHON, $(HOST_BUILDDIR))
	@$(call patchin, PYTHON, $(HOST_PYTHON_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PYTHON_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--with-cyclic-gc \
	--with-pymalloc \
	--with-signal-module \
	--with-threads \
	--with-wctype-functions \
	--without-cxx

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON,,h)
	install -m 0755 $(HOST_PYTHON_DIR)/Parser/pgen $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-python_clean:
	rm -rf $(STATEDIR)/host-python.*
	rm -rf $(HOST_PYTHON_DIR)

# vim: syntax=make

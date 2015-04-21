# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LOCALEDEF) += host-localedef

#
# Paths and names
#
HOST_LOCALEDEF_VERSION	:= eglibc-2.9-ptx1
HOST_LOCALEDEF		:= localedef-$(HOST_LOCALEDEF_VERSION)
HOST_LOCALEDEF_SUFFIX	:= tar.bz2
HOST_LOCALEDEF_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOST_LOCALEDEF).$(HOST_LOCALEDEF_SUFFIX)
HOST_LOCALEDEF_SOURCE	:= $(SRCDIR)/$(HOST_LOCALEDEF).$(HOST_LOCALEDEF_SUFFIX)
HOST_LOCALEDEF_DIR	:= $(HOST_BUILDDIR)/$(HOST_LOCALEDEF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_LOCALEDEF_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_LOCALEDEF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LOCALEDEF_PATH	:= PATH=$(HOST_PATH)
HOST_LOCALEDEF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LOCALEDEF_AUTOCONF	:= \
	--with-glibc=./eglibc-2.9 \
	--prefix=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-localedef.install:
	@$(call targetinfo)
	cp $(HOST_LOCALEDEF_DIR)/localedef $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-localedef_clean:
	rm -rf $(STATEDIR)/host-localedef.*
	rm -rf $(HOST_LOCALEDEF_DIR)

# vim: syntax=make

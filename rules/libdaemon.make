# -*-makefile-*-
# $Id: libdaemon.make,v 1.7 2007-07-15 19:14:38 michl Exp $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDAEMON) += libdaemon

#
# Paths and names
#
LIBDAEMON_VERSION	:= 0.12
LIBDAEMON		:= libdaemon-$(LIBDAEMON_VERSION)
LIBDAEMON_SUFFIX	:= tar.gz
LIBDAEMON_URL		:= http://0pointer.de/lennart/projects/libdaemon/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_SOURCE	:= $(SRCDIR)/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_DIR		:= $(BUILDDIR)/$(LIBDAEMON)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBDAEMON_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBDAEMON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBDAEMON_PATH	:=  PATH=$(CROSS_PATH)
LIBDAEMON_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBDAEMON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdaemon.targetinstall: $(libdaemon_targetinstall_deps_default)
	@$(call targetinfo)

	@$(call install_init, libdaemon)
	@$(call install_fixup,libdaemon,PACKAGE,libdaemon)
	@$(call install_fixup,libdaemon,PRIORITY,optional)
	@$(call install_fixup,libdaemon,VERSION,$(LIBDAEMON_VERSION))
	@$(call install_fixup,libdaemon,SECTION,base)
	@$(call install_fixup,libdaemon,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,libdaemon,DEPENDS,)
	@$(call install_fixup,libdaemon,DESCRIPTION,missing)

	@$(call install_copy, libdaemon, 0, 0, 0644, -, \
		/usr/lib/libdaemon.so.0.3.1)

	@$(call install_link, libdaemon, \
		libdaemon.so.0.3.1, \
		/usr/lib/libdaemon.so.0)

	@$(call install_link, libdaemon, \
		libdaemon.so.0.3.1, \
		/usr/lib/libdaemon.so)

	@$(call install_finish,libdaemon)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libdaemon_clean:
	rm -rf $(STATEDIR)/libdaemon.*
	rm -rf $(PKGDIR)/libdaemon_*
	rm -rf $(LIBDAEMON_DIR)

# vim: syntax=make

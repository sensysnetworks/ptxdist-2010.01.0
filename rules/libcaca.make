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
PACKAGES-$(PTXCONF_LIBCACA) += libcaca

#
# Paths and names
#
LIBCACA_VERSION	:= 0.99.beta16
LIBCACA		:= libcaca-$(LIBCACA_VERSION)
LIBCACA_SUFFIX	:= tar.gz
LIBCACA_URL	:= http://caca.zoy.org/files/libcaca/$(LIBCACA).$(LIBCACA_SUFFIX)
LIBCACA_SOURCE	:= $(SRCDIR)/$(LIBCACA).$(LIBCACA_SUFFIX)
LIBCACA_DIR	:= $(BUILDDIR)/$(LIBCACA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCACA_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCACA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCACA_PATH	:= PATH=$(CROSS_PATH)
LIBCACA_ENV 	:= \
	$(CROSS_ENV) \
	$(call ptx/ncurses, PTXCONF_LIBCACA_NCURSES)

#
# autoconf
#
LIBCACA_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	\
	--disable-slang \
	--disable-conio \
	--disable-cocoa \
	--disable-network \
	--disable-vga \
	--disable-csharp \
	--disable-ruby \
	--disable-imlib2 \
	--disable-debug \
	--disable-plugins \
	--disable-cppunit \
	--disable-zzuf \
	\
	--$(call ptx/endis, PTXCONF_LIBCACA_NCURSES)-ncurses \
	--$(call ptx/endis, PTXCONF_LIBCACA_X11)-x11 \
	--$(call ptx/endis, PTXCONF_LIBCACA_GL)-gl \
	--$(call ptx/endis, PTXCONF_LIBCACA_CXX)-cxx

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcaca.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcaca)
	@$(call install_fixup, libcaca,PACKAGE,libcaca)
	@$(call install_fixup, libcaca,PRIORITY,optional)
	@$(call install_fixup, libcaca,VERSION,$(LIBCACA_VERSION))
	@$(call install_fixup, libcaca,SECTION,base)
	@$(call install_fixup, libcaca,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libcaca,DEPENDS,)
	@$(call install_fixup, libcaca,DESCRIPTION,missing)

	@$(call install_copy, libcaca, 0, 0, 0644, -, /usr/lib/libcaca.so.0.99.16)
	@$(call install_link, libcaca, libcaca.so.0.99.16, /usr/lib/libcaca.so.0)
	@$(call install_link, libcaca, libcaca.so.0.99.16, /usr/lib/libcaca.so)

ifdef PTXCONF_LIBCACA_CXX
	@$(call install_copy, libcaca, 0, 0, 0644, -, /usr/lib/libcaca++.so.0.99.16)
	@$(call install_link, libcaca, libcaca++.so.0.99.16, /usr/lib/libcaca++.so.0)
	@$(call install_link, libcaca, libcaca++.so.0.99.16, /usr/lib/libcaca++.so)
endif

	@$(call install_finish, libcaca)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcaca_clean:
	rm -rf $(STATEDIR)/libcaca.*
	rm -rf $(PKGDIR)/libcaca_*
	rm -rf $(LIBCACA_DIR)

# vim: syntax=make

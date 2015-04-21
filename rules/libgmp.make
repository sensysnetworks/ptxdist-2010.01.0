# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
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
PACKAGES-$(PTXCONF_LIBGMP) += libgmp

#
# Paths and names
#
LIBGMP_VERSION	:= 4.2.4
LIBGMP		:= gmp-$(LIBGMP_VERSION)
LIBGMP_SUFFIX	:= tar.bz2
LIBGMP_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/gmp/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_SOURCE	:= $(SRCDIR)/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_DIR	:= $(BUILDDIR)/$(LIBGMP)
LIBGMP_LICENSE	:= GPLv3, LGPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGMP_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGMP_PATH	:= PATH=$(CROSS_PATH)
LIBGMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGMP_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBGMP_SHARED
LIBGMP_AUTOCONF += --enable-shared
else
LIBGMP_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_LIBGMP_STATIC
LIBGMP_AUTOCONF += --enable-static
else
LIBGMP_AUTOCONF += --disable-static
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgmp)
	@$(call install_fixup, libgmp,PACKAGE,libgmp)
	@$(call install_fixup, libgmp,PRIORITY,optional)
	@$(call install_fixup, libgmp,VERSION,$(LIBGMP_VERSION))
	@$(call install_fixup, libgmp,SECTION,base)
	@$(call install_fixup, libgmp,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libgmp,DEPENDS,)
	@$(call install_fixup, libgmp,DESCRIPTION,missing)

ifdef PTXCONF_LIBGMP_SHARED
	@$(call install_copy, libgmp, 0, 0, 0644, -, \
		/usr/lib/libgmp.so.3.4.4)
	@$(call install_link, libgmp, libgmp.so.3.4.4, /usr/lib/libgmp.so.3)
	@$(call install_link, libgmp, libgmp.so.3.4.4, /usr/lib/libgmp.so)
endif

ifdef PTXCONF_LIBGMP_STATIC
	@$(call install_copy, libgmp, 0, 0, 0644, -, \
		/usr/lib/libgmp.la)
endif

	@$(call install_finish, libgmp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgmp_clean:
	rm -rf $(STATEDIR)/libgmp.*
	rm -rf $(PKGDIR)/libgmp_*
	rm -rf $(LIBGMP_DIR)

# vim: syntax=make

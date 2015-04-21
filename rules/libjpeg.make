# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBJPEG) += libjpeg

#
# Paths and names
#
LIBJPEG_VERSION	:= 7
LIBJPEG_SUFFIX	:= tar.gz
LIBJPEG		:= jpeg-$(LIBJPEG_VERSION)
LIBJPEG_TARBALL	:= jpegsrc.v$(LIBJPEG_VERSION).$(LIBJPEG_SUFFIX)
LIBJPEG_URL	:= http://ijg.org/files/$(LIBJPEG_TARBALL)
LIBJPEG_SOURCE	:= $(SRCDIR)/$(LIBJPEG_TARBALL)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)
LIBJPEG_LICENSE	:= jpeg

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBJPEG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBJPEG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBJPEG_PATH	:= PATH=$(CROSS_PATH)
LIBJPEG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBJPEG_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libjpeg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libjpeg)
	@$(call install_fixup, libjpeg,PACKAGE,libjpeg)
	@$(call install_fixup, libjpeg,PRIORITY,optional)
	@$(call install_fixup, libjpeg,VERSION,$(LIBJPEG_VERSION))
	@$(call install_fixup, libjpeg,SECTION,base)
	@$(call install_fixup, libjpeg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libjpeg,DEPENDS,)
	@$(call install_fixup, libjpeg,DESCRIPTION,missing)

	@$(call install_copy, libjpeg, 0, 0, 0644, -, \
		/usr/lib/libjpeg.so.7.0.0)
	@$(call install_link, libjpeg, libjpeg.so.7.0.0, /usr/lib/libjpeg.so.7)
	@$(call install_link, libjpeg, libjpeg.so.7.0.0, /usr/lib/libjpeg.so)

	@$(call install_finish, libjpeg)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libjpeg_clean:
	rm -rf $(STATEDIR)/libjpeg.*
	rm -rf $(PKGDIR)/libjpeg_*
	rm -rf $(LIBJPEG_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003, 2008 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTELNETD) += utelnetd

#
# Paths and names
#
UTELNETD_VERSION	:= 0.1.11
UTELNETD		:= utelnetd-$(UTELNETD_VERSION)
UTELNETD_URL		:= http://www.pengutronix.de/software/utelnetd/$(UTELNETD).tar.gz
UTELNETD_SOURCE		:= $(SRCDIR)/$(UTELNETD).tar.gz
UTELNETD_DIR		:= $(BUILDDIR)/$(UTELNETD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UTELNETD_SOURCE):
	@$(call targetinfo)
	@$(call get, UTELNETD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/utelnetd.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

UTELNETD_PATH	:= PATH=$(CROSS_PATH)
UTELNETD_ENV	:= PATH=$(CROSS_PATH)

UTELNETD_COMPILE_ENV := \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	$(CROSS_ENV_FLAGS)

UTELNETD_MAKEVARS := INSTDIR=/sbin

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/utelnetd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, utelnetd)
	@$(call install_fixup, utelnetd,PACKAGE,utelnetd)
	@$(call install_fixup, utelnetd,PRIORITY,optional)
	@$(call install_fixup, utelnetd,VERSION,$(UTELNETD_VERSION))
	@$(call install_fixup, utelnetd,SECTION,base)
	@$(call install_fixup, utelnetd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, utelnetd,DEPENDS,)
	@$(call install_fixup, utelnetd,DESCRIPTION,missing)

	@$(call install_copy, utelnetd, 0, 0, 0755, -, \
		/sbin/utelnetd)

	#
	# busybox init
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_UTELNETD_STARTSCRIPT
	@$(call install_alternative, utelnetd, 0, 0, 0755, /etc/init.d/telnetd, n)
endif
endif

	@$(call install_finish, utelnetd)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

utelnetd_clean:
	rm -rf $(STATEDIR)/utelnetd.*
	rm -rf $(PKGDIR)/utelnetd_*
	rm -rf $(UTELNETD_DIR)

# vim: syntax=make

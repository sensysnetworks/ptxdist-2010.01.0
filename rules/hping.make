# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HPING) += hping

#
# Paths and names
#
HPING_VERSION	:= 3-20051105
HPING		:= hping$(HPING_VERSION)
HPING_SUFFIX	:= tar.gz
HPING_URL	:= http://www.hping.org/$(HPING).$(HPING_SUFFIX)
HPING_SOURCE	:= $(SRCDIR)/$(HPING).$(HPING_SUFFIX)
HPING_DIR	:= $(BUILDDIR)/$(HPING)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HPING_SOURCE):
	@$(call targetinfo)
	@$(call get, HPING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HPING_PATH	:= PATH=$(CROSS_PATH)
HPING_ENV 	:= \
	$(CROSS_ENV) \
	MANPATH=/usr/man

HPING_MAKEVARS	:= $(CROSS_ENV)

#
# autoconf
#
HPING_AUTOCONF := --no-tcl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hping.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hping)
	@$(call install_fixup, hping,PACKAGE,hping)
	@$(call install_fixup, hping,PRIORITY,optional)
	@$(call install_fixup, hping,VERSION,$(HPING_VERSION))
	@$(call install_fixup, hping,SECTION,base)
	@$(call install_fixup, hping,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, hping,DEPENDS,)
	@$(call install_fixup, hping,DESCRIPTION,missing)

	@$(call install_copy, hping, 0, 0, 0755, -, /usr/sbin/hping3)

	@$(call install_finish, hping)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hping_clean:
	rm -rf $(STATEDIR)/hping.*
	rm -rf $(PKGDIR)/hping_*
	rm -rf $(HPING_DIR)

# vim: syntax=make

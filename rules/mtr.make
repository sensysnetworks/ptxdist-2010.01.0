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
PACKAGES-$(PTXCONF_MTR) += mtr

#
# Paths and names
#
MTR_VERSION	:= 0.75
MTR		:= mtr-$(MTR_VERSION)
MTR_SUFFIX	:= tar.gz
MTR_URL		:= ftp://ftp.bitwizard.nl/mtr/$(MTR).$(MTR_SUFFIX)
MTR_SOURCE	:= $(SRCDIR)/$(MTR).$(MTR_SUFFIX)
MTR_DIR		:= $(BUILDDIR)/$(MTR)
MTR_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MTR_SOURCE):
	@$(call targetinfo)
	@$(call get, MTR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MTR_PATH	:= PATH=$(CROSS_PATH)
MTR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MTR_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-gtk

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtr.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  mtr)
	@$(call install_fixup, mtr,PACKAGE,mtr)
	@$(call install_fixup, mtr,PRIORITY,optional)
	@$(call install_fixup, mtr,VERSION,$(MTR_VERSION))
	@$(call install_fixup, mtr,SECTION,base)
	@$(call install_fixup, mtr,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, mtr,DEPENDS,)
	@$(call install_fixup, mtr,DESCRIPTION,missing)

	@$(call install_copy, mtr, 0, 0, 4755, -, /usr/sbin/mtr)

	@$(call install_finish, mtr)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtr_clean:
	rm -rf $(STATEDIR)/mtr.*
	rm -rf $(PKGDIR)/mtr_*
	rm -rf $(MTR_DIR)

# vim: syntax=make

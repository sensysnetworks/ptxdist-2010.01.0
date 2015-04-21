# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PRELINK) += prelink

#
# Paths and names
#
PRELINK_VERSION	:= 0.0.20071009
PRELINK_SUFFIX	:= orig.tar.gz
PRELINK		:= prelink-$(PRELINK_VERSION)
PRELINK_TARBALL	:= prelink_$(PRELINK_VERSION).$(PRELINK_SUFFIX)
PRELINK_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/p/prelink/$(PRELINK_TARBALL)
PRELINK_SOURCE	:= $(SRCDIR)/$(PRELINK_TARBALL)
PRELINK_DIR	:= $(BUILDDIR)/$(PRELINK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PRELINK_SOURCE):
	@$(call targetinfo)
	@$(call get, PRELINK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PRELINK_PATH	:= PATH=$(CROSS_PATH)
PRELINK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PRELINK_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/prelink.targetinstall:
	@$(call targetinfo)

	@$(call install_init, prelink)
	@$(call install_fixup, prelink,PACKAGE,prelink)
	@$(call install_fixup, prelink,PRIORITY,optional)
	@$(call install_fixup, prelink,VERSION,$(PRELINK_VERSION))
	@$(call install_fixup, prelink,SECTION,base)
	@$(call install_fixup, prelink,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, prelink,DEPENDS,)
	@$(call install_fixup, prelink,DESCRIPTION,missing)

	@$(call install_alternative, prelink, 0, 0, 0644, /etc/prelink.conf)
	@$(call install_copy, prelink, 0, 0, 0755, -, /usr/sbin/prelink)

	@$(call install_finish, prelink)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

prelink_clean:
	rm -rf $(STATEDIR)/prelink.*
	rm -rf $(PKGDIR)/prelink_*
	rm -rf $(PRELINK_DIR)

# vim: syntax=make

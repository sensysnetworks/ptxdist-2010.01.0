# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEDIT) += libedit

#
# Paths and names
#
LIBEDIT_VERSION	:= 20090610-3.0
LIBEDIT		:= libedit-$(LIBEDIT_VERSION)
LIBEDIT_SUFFIX	:= tar.gz
LIBEDIT_URL	:= http://www.thrysoee.dk/editline/$(LIBEDIT).$(LIBEDIT_SUFFIX)
LIBEDIT_SOURCE	:= $(SRCDIR)/$(LIBEDIT).$(LIBEDIT_SUFFIX)
LIBEDIT_DIR	:= $(BUILDDIR)/$(LIBEDIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBEDIT_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBEDIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEDIT_PATH	:= PATH=$(CROSS_PATH)
LIBEDIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBEDIT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libedit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libedit)
	@$(call install_fixup, libedit,PACKAGE,libedit)
	@$(call install_fixup, libedit,PRIORITY,optional)
	@$(call install_fixup, libedit,VERSION,$(LIBEDIT_VERSION))
	@$(call install_fixup, libedit,SECTION,base)
	@$(call install_fixup, libedit,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libedit,DEPENDS,)
	@$(call install_fixup, libedit,DESCRIPTION,missing)

	@$(call install_copy, libedit, 0, 0, 0755, -, /usr/lib/libedit.so.0.0.31)
	@$(call install_link, libedit, libedit.so.0.0.31, /usr/lib/libedit.so.0)
	@$(call install_link, libedit, libedit.so.0.0.31, /usr/lib/libedit.so)

	@$(call install_finish, libedit)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libedit_clean:
	rm -rf $(STATEDIR)/libedit.*
	rm -rf $(PKGDIR)/libedit_*
	rm -rf $(LIBEDIT_DIR)

# vim: syntax=make

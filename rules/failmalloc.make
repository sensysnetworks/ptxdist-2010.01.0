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
PACKAGES-$(PTXCONF_FAILMALLOC) += failmalloc

#
# Paths and names
#
FAILMALLOC_VERSION	:= 1.0
FAILMALLOC		:= failmalloc-$(FAILMALLOC_VERSION)
FAILMALLOC_SUFFIX	:= tar.gz
FAILMALLOC_URL		:= http://download.savannah.nongnu.org/releases/failmalloc/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_SOURCE	:= $(SRCDIR)/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_DIR		:= $(BUILDDIR)/$(FAILMALLOC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FAILMALLOC_SOURCE):
	@$(call targetinfo)
	@$(call get, FAILMALLOC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FAILMALLOC_PATH	:= PATH=$(CROSS_PATH)
FAILMALLOC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAILMALLOC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static=no \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/failmalloc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, failmalloc)
	@$(call install_fixup, failmalloc,PACKAGE,failmalloc)
	@$(call install_fixup, failmalloc,PRIORITY,optional)
	@$(call install_fixup, failmalloc,VERSION,$(FAILMALLOC_VERSION))
	@$(call install_fixup, failmalloc,SECTION,base)
	@$(call install_fixup, failmalloc,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, failmalloc,DEPENDS,)
	@$(call install_fixup, failmalloc,DESCRIPTION,missing)

	@$(call install_copy, failmalloc, 0, 0, 0644, -,  \
		/usr/lib/libfailmalloc.so.0.0.0)
	@$(call install_link, failmalloc, libfailmalloc.so.0.0.0, \
		/usr/lib/libfailmalloc.so.0)
	@$(call install_link, failmalloc, libfailmalloc.so.0.0.0, \
		/usr/lib/libfailmalloc.so)

	@$(call install_finish, failmalloc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

failmalloc_clean:
	rm -rf $(STATEDIR)/failmalloc.*
	rm -rf $(PKGDIR)/failmalloc_*
	rm -rf $(FAILMALLOC_DIR)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2010 by Ian Lance Taylor
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UUCP) += uucp

#
# Paths and names
#
UUCP_VERSION	:= 1.07
UUCP		:= uucp-$(UUCP_VERSION)
UUCP_SUFFIX		:= tar.gz
UUCP_URL		:= ftp://ftp.gnu.org/pub/gnu/uucp/$(UUCP).$(UUCP_SUFFIX)
UUCP_SOURCE		:= $(SRCDIR)/$(UUCP).$(UUCP_SUFFIX)
UUCP_DIR		:= $(BUILDDIR)/$(UUCP)
UUCP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UUCP_SOURCE):
	@$(call targetinfo)
	@$(call get, UUCP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UUCP_PATH	:= PATH=$(CROSS_PATH)
UUCP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
UUCP_AUTOCONF := $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/uucp.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(UUCP_DIR)/config.cache)
#	cd $(UUCP_DIR) && \
#		$(UUCP_PATH) $(UUCP_ENV) \
#		./configure $(UUCP_AUTOCONF)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/uucp.compile:
#	@$(call targetinfo)
#	cd $(UUCP_DIR) && $(UUCP_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/uucp.install:
#	@$(call targetinfo)
#	@$(call install, UUCP)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/uucp.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  uucp)
	@$(call install_fixup, uucp,PACKAGE,uucp)
	@$(call install_fixup, uucp,PRIORITY,optional)
	@$(call install_fixup, uucp,VERSION,$(UUCP_VERSION))
	@$(call install_fixup, uucp,SECTION,base)
	@$(call install_fixup, uucp,AUTHOR,"Ian Lance Taylor")
	@$(call install_fixup, uucp,DEPENDS,)
	@$(call install_fixup, uucp,DESCRIPTION,missing)

	@$(call install_copy, uucp, 0, 0, 0755, $(UUCP_DIR)/cu, /usr/bin/cu)

	@$(call install_finish, uucp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

uucp_clean:
	rm -rf $(STATEDIR)/uucp.*
	rm -rf $(PKGDIR)/uucp_*
	rm -rf $(UUCP_DIR)

# vim: syntax=make

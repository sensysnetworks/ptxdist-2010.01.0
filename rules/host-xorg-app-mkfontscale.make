# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_MKFONTSCALE) += host-xorg-app-mkfontscale

#
# Paths and names
#
HOST_XORG_APP_MKFONTSCALE_DIR	= $(HOST_BUILDDIR)/$(XORG_APP_MKFONTSCALE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_get: $(STATEDIR)/host-xorg-app-mkfontscale.get

$(STATEDIR)/host-xorg-app-mkfontscale.get: $(STATEDIR)/xorg-app-mkfontscale.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_extract: $(STATEDIR)/host-xorg-app-mkfontscale.extract

$(STATEDIR)/host-xorg-app-mkfontscale.extract: $(host-xorg-app-mkfontscale_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_MKFONTSCALE_DIR))
	@$(call extract, XORG_APP_MKFONTSCALE, $(HOST_BUILDDIR))
	@$(call patchin, XORG_APP_MKFONTSCALE, $(HOST_XORG_APP_MKFONTSCALE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_prepare: $(STATEDIR)/host-xorg-app-mkfontscale.prepare

HOST_XORG_APP_MKFONTSCALE_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_APP_MKFONTSCALE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_MKFONTSCALE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-app-mkfontscale.prepare: $(host-xorg-app-mkfontscale_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_MKFONTSCALE_DIR)/config.cache)
	cd $(HOST_XORG_APP_MKFONTSCALE_DIR) && \
		$(HOST_XORG_APP_MKFONTSCALE_PATH) $(HOST_XORG_APP_MKFONTSCALE_ENV) \
		./configure $(HOST_XORG_APP_MKFONTSCALE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_compile: $(STATEDIR)/host-xorg-app-mkfontscale.compile

$(STATEDIR)/host-xorg-app-mkfontscale.compile: $(host-xorg-app-mkfontscale_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_APP_MKFONTSCALE_DIR) && $(HOST_XORG_APP_MKFONTSCALE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_install: $(STATEDIR)/host-xorg-app-mkfontscale.install

$(STATEDIR)/host-xorg-app-mkfontscale.install: $(host-xorg-app-mkfontscale_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_APP_MKFONTSCALE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-app-mkfontscale_clean:
	rm -rf $(STATEDIR)/host-xorg-app-mkfontscale.*
	rm -rf $(HOST_XORG_APP_MKFONTSCALE_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PANGO) += host-pango

#
# Paths and names
#
HOST_PANGO_DIR	= $(HOST_BUILDDIR)/$(PANGO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-pango_get: $(STATEDIR)/host-pango.get

$(STATEDIR)/host-pango.get: $(STATEDIR)/pango.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-pango_extract: $(STATEDIR)/host-pango.extract

$(STATEDIR)/host-pango.extract: $(host-pango_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PANGO_DIR))
	@$(call extract, PANGO, $(HOST_BUILDDIR))
	@$(call patchin, PANGO, $(HOST_PANGO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-pango_prepare: $(STATEDIR)/host-pango.prepare

HOST_PANGO_PATH	:= PATH=$(HOST_PATH)
HOST_PANGO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
ifdef PTXCONF_HOST_PANGO_BASIC
HOST_PANGO_MODULES += basic-fc,basic-win32,basic-x,basic-atsui
endif

ifdef PTXCONF_HOST_PANGO_ARABIC
HOST_PANGO_MODULES += arabic-fc
endif

ifdef PTXCONF_HOST_PANGO_HANGUL
HOST_PANGO_MODULES += hangul-fc
endif

ifdef PTXCONF_HOST_PANGO_HEBREW
HOST_PANGO_MODULES += hebrew-fc
endif

ifdef PTXCONF_HOST_PANGO_INDIC
HOST_PANGO_MODULES += indic-fc,indic-lang
endif

ifdef PTXCONF_HOST_PANGO_KHMER
HOST_PANGO_MODULES += khmer-fc
endif

ifdef PTXCONF_HOST_PANGO_SYRIAC
HOST_PANGO_MODULES += syriac-fc
endif

ifdef PTXCONF_HOST_PANGO_THAI
HOST_PANGO_MODULES += thai-fc
endif

ifdef PTXCONF_HOST_PANGO_TIBETAN
HOST_PANGO_MODULES += tibetan-fc
endif

HOST_PANGO_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-explicit-deps=yes \
	--without-dynamic-modules \
	--with-included-modules=$(subst $(space),$(comma),$(HOST_PANGO_MODULES))

#ifdef PTXCONF_PANGO_TARGET_X11
#HOST_PANGO_AUTOCONF += --with-x=$(SYSROOT)/usr
#else
#HOST_PANGO_AUTOCONF += --without-x
#endif

$(STATEDIR)/host-pango.prepare: $(host-pango_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PANGO_DIR)/config.cache)
	cd $(HOST_PANGO_DIR) && \
		$(HOST_PANGO_PATH) $(HOST_PANGO_ENV) \
		./configure $(HOST_PANGO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-pango_compile: $(STATEDIR)/host-pango.compile

$(STATEDIR)/host-pango.compile: $(host-pango_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_PANGO_DIR) && $(HOST_PANGO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-pango_install: $(STATEDIR)/host-pango.install

$(STATEDIR)/host-pango.install: $(host-pango_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_PANGO,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pango_clean:
	rm -rf $(STATEDIR)/host-pango.*
	rm -rf $(HOST_PANGO_DIR)

# vim: syntax=make

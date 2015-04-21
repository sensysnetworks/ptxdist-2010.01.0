# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_XFREE86_TYPE1) += xorg-font-xfree86-type1

#
# Paths and names
#
XORG_FONT_XFREE86_TYPE1_VERSION	:= 1.0.2
XORG_FONT_XFREE86_TYPE1		:= font-xfree86-type1-$(XORG_FONT_XFREE86_TYPE1_VERSION)
XORG_FONT_XFREE86_TYPE1_SUFFIX	:= tar.bz2
XORG_FONT_XFREE86_TYPE1_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_XFREE86_TYPE1).$(XORG_FONT_XFREE86_TYPE1_SUFFIX)
XORG_FONT_XFREE86_TYPE1_SOURCE	:= $(SRCDIR)/$(XORG_FONT_XFREE86_TYPE1).$(XORG_FONT_XFREE86_TYPE1_SUFFIX)
XORG_FONT_XFREE86_TYPE1_DIR	:= $(BUILDDIR)/$(XORG_FONT_XFREE86_TYPE1)

ifdef PTXCONF_XORG_FONT_XFREE86_TYPE1
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-xfree86-type1.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_get: $(STATEDIR)/xorg-font-xfree86-type1.get

$(STATEDIR)/xorg-font-xfree86-type1.get: $(xorg-font-xfree86-type1_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_XFREE86_TYPE1_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_XFREE86_TYPE1)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_extract: $(STATEDIR)/xorg-font-xfree86-type1.extract

$(STATEDIR)/xorg-font-xfree86-type1.extract: $(xorg-font-xfree86-type1_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_XFREE86_TYPE1_DIR))
	@$(call extract, XORG_FONT_XFREE86_TYPE1)
	@$(call patchin, XORG_FONT_XFREE86_TYPE1)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_prepare: $(STATEDIR)/xorg-font-xfree86-type1.prepare

XORG_FONT_XFREE86_TYPE1_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_XFREE86_TYPE1_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_XFREE86_TYPE1_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/Type1

$(STATEDIR)/xorg-font-xfree86-type1.prepare: $(xorg-font-xfree86-type1_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_XFREE86_TYPE1_DIR)/config.cache)
	cd $(XORG_FONT_XFREE86_TYPE1_DIR) && \
		$(XORG_FONT_XFREE86_TYPE1_PATH) $(XORG_FONT_XFREE86_TYPE1_ENV) \
		./configure $(XORG_FONT_XFREE86_TYPE1_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_compile: $(STATEDIR)/xorg-font-xfree86-type1.compile

$(STATEDIR)/xorg-font-xfree86-type1.compile: $(xorg-font-xfree86-type1_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_XFREE86_TYPE1_DIR) && $(XORG_FONT_XFREE86_TYPE1_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_install: $(STATEDIR)/xorg-font-xfree86-type1.install

$(STATEDIR)/xorg-font-xfree86-type1.install: $(xorg-font-xfree86-type1_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_targetinstall: $(STATEDIR)/xorg-font-xfree86-type1.targetinstall

$(STATEDIR)/xorg-font-xfree86-type1.targetinstall: $(xorg-font-xfree86-type1_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/Type1

	@find $(XORG_FONT_XFREE86_TYPE1_DIR) \
		-name "*.pfa" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/Type1; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-xfree86-type1_clean:
	rm -rf $(STATEDIR)/xorg-font-xfree86-type1.*
	rm -rf $(PKGDIR)/xorg-font-xfree86-type1_*
	rm -rf $(XORG_FONT_XFREE86_TYPE1_DIR)

# vim: syntax=make

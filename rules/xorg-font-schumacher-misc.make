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
PACKAGES-$(PTXCONF_XORG_FONT_SCHUMACHER_MISC) += xorg-font-schumacher-misc

#
# Paths and names
#
XORG_FONT_SCHUMACHER_MISC_VERSION	:= 1.1.0
XORG_FONT_SCHUMACHER_MISC		:= font-schumacher-misc-$(XORG_FONT_SCHUMACHER_MISC_VERSION)
XORG_FONT_SCHUMACHER_MISC_SUFFIX	:= tar.bz2
XORG_FONT_SCHUMACHER_MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_SCHUMACHER_MISC).$(XORG_FONT_SCHUMACHER_MISC_SUFFIX)
XORG_FONT_SCHUMACHER_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_SCHUMACHER_MISC).$(XORG_FONT_SCHUMACHER_MISC_SUFFIX)
XORG_FONT_SCHUMACHER_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_SCHUMACHER_MISC)

ifdef PTXCONF_XORG_FONT_SCHUMACHER_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-schumacher-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_get: $(STATEDIR)/xorg-font-schumacher-misc.get

$(STATEDIR)/xorg-font-schumacher-misc.get: $(xorg-font-schumacher-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_SCHUMACHER_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_SCHUMACHER_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_extract: $(STATEDIR)/xorg-font-schumacher-misc.extract

$(STATEDIR)/xorg-font-schumacher-misc.extract: $(xorg-font-schumacher-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_SCHUMACHER_MISC_DIR))
	@$(call extract, XORG_FONT_SCHUMACHER_MISC)
	@$(call patchin, XORG_FONT_SCHUMACHER_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_prepare: $(STATEDIR)/xorg-font-schumacher-misc.prepare

XORG_FONT_SCHUMACHER_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_SCHUMACHER_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_SCHUMACHER_MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-schumacher-misc.prepare: $(xorg-font-schumacher-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_SCHUMACHER_MISC_DIR)/config.cache)
	cd $(XORG_FONT_SCHUMACHER_MISC_DIR) && \
		$(XORG_FONT_SCHUMACHER_MISC_PATH) $(XORG_FONT_SCHUMACHER_MISC_ENV) \
		./configure $(XORG_FONT_SCHUMACHER_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_compile: $(STATEDIR)/xorg-font-schumacher-misc.compile

$(STATEDIR)/xorg-font-schumacher-misc.compile: $(xorg-font-schumacher-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_SCHUMACHER_MISC_DIR) && $(XORG_FONT_SCHUMACHER_MISC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_install: $(STATEDIR)/xorg-font-schumacher-misc.install

$(STATEDIR)/xorg-font-schumacher-misc.install: $(xorg-font-schumacher-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_targetinstall: $(STATEDIR)/xorg-font-schumacher-misc.targetinstall

$(STATEDIR)/xorg-font-schumacher-misc.targetinstall: $(xorg-font-schumacher-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_SCHUMACHER_MISC_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" -a \! -name "*KOI*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

# FIXME: care about KOI fonts

ifdef PTXCONF_XORG_FONT_SCHUMACHER_MISC_TRANS
	@find $(XORG_FONT_SCHUMACHER_MISC_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-5.pcf.gz" \
		-o -name "*ISO8859-6.pcf.gz" \
		-o -name "*ISO8859-7.pcf.gz" \
		-o -name "*ISO8859-8.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		-o -name "*ISO8859-16.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-schumacher-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-schumacher-misc.*
	rm -rf $(PKGDIR)/xorg-font-schumacher-misc_*
	rm -rf $(XORG_FONT_SCHUMACHER_MISC_DIR)

# vim: syntax=make

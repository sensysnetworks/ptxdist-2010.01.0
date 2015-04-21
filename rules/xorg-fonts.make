# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONTS) += xorg-fonts

#
# Paths and names
#
XORG_FONTS_VERSION	:= 1.0.0
XORG_FONTS		:= xorg-fonts-$(XORG_FONTS_VERSION)
XORG_FONTS_DIR		:= $(BUILDDIR)/$(XORG_FONTS)
XORG_FONTS_DIR_INSTALL	:= $(XORG_FONTS_DIR)-install

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-fonts_get: $(STATEDIR)/xorg-fonts.get

$(STATEDIR)/xorg-fonts.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-fonts_extract: $(STATEDIR)/xorg-fonts.extract

$(STATEDIR)/xorg-fonts.extract: $(xorg-fonts_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-fonts_prepare: $(STATEDIR)/xorg-fonts.prepare

XORG_FONTS_PATH	:=  PATH=$(HOST_PATH)

$(STATEDIR)/xorg-fonts.prepare: $(xorg-fonts_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-fonts_compile: $(STATEDIR)/xorg-fonts.compile

$(STATEDIR)/xorg-fonts.compile: $(xorg-fonts_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-fonts_install: $(STATEDIR)/xorg-fonts.install

$(STATEDIR)/xorg-fonts.install: $(xorg-fonts_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-fonts_targetinstall: $(STATEDIR)/xorg-fonts.targetinstall.post

$(STATEDIR)/xorg-fonts.targetinstall: $(xorg-fonts_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@if test -e $(XORG_FONTS_DIR_INSTALL); then \
		rm -rf $(XORG_FONTS_DIR_INSTALL); \
	fi
	@mkdir -p $(XORG_FONTS_DIR_INSTALL)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-fonts.install
	@$(call targetinfo, $@)

	@$(XORG_FONTS_PATH); \
	find $(XORG_FONTS_DIR_INSTALL) -mindepth 1 -type d | while read dir; do \
		echo $$dir;\
		case "$${dir}" in \
			*/[Ee]ncodings)	\
					if test -d "$${dir}/large"; then \
						elarge="-e ./large"; \
					fi; \
					pushd $${dir} > /dev/null; \
					mkfontscale -b -s -l -n -r -p $(XORG_FONTDIR)/encodings -e . $${elarge} $${dir}; \
					popd > /dev/null ;; \
			*/[Ss]peedo)	mkfontdir $${dir} ;; \
			*)		mkfontscale $${dir}; \
					mkfontdir $${dir} ;; \
		esac; \
	done

# FIXME: add fc-cache?

	@$(call install_init, xorg-fonts)
	@$(call install_fixup, xorg-fonts,PACKAGE,xorg-fonts)
	@$(call install_fixup, xorg-fonts,PRIORITY,optional)
	@$(call install_fixup, xorg-fonts,VERSION,$(XORG_FONTS_VERSION))
	@$(call install_fixup, xorg-fonts,SECTION,base)
	@$(call install_fixup, xorg-fonts,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-fonts,DEPENDS,)
	@$(call install_fixup, xorg-fonts,DESCRIPTION,missing)

	@cd $(XORG_FONTS_DIR_INSTALL); \
	find . -type f | while read file; do \
		echo $${file}; \
		$(call install_copy, xorg-fonts, 0, 0, 0644, $$file, $(XORG_FONTDIR)/$$file, n); \
	done

	@$(call install_finish, xorg-fonts)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-fonts_clean:
	rm -rf $(STATEDIR)/xorg-fonts.*
	rm -rf $(PKGDIR)/xorg-fonts_*
	rm -rf $(XORG_FONTS_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_100DPI) += xorg-font-bh-lucidatypewriter-100dpi

#
# Paths and names
#
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_VERSION	:= 1.0.1
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI		:= font-bh-lucidatypewriter-100dpi-$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_VERSION)
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI).$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_SUFFIX)
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI).$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_SUFFIX)
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI)

ifdef PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bh-lucidatypewriter-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_BH_LUCIDATYPEWRITER_100DPI)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontrootdir=$(XORG_FONTDIR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bh-lucidatypewriter-100dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bh-lucidatypewriter-100dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@find $(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

ifdef PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_TRANS
	@find $(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-100dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-bh-lucidatypewriter-100dpi.*
	rm -rf $(PKGDIR)/xorg-font-bh-lucidatypewriter-100dpi_*
	rm -rf $(XORG_FONT_BH_LUCIDATYPEWRITER_100DPI_DIR)

# vim: syntax=make
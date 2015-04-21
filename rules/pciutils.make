# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Wolfram Sang, Pengutronix
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HAS_PCI)-$(PTXCONF_PCIUTILS) += pciutils

#
# Paths and names
#
PCIUTILS_VERSION	:= 3.1.2
PCIUTILS		:= pciutils-$(PCIUTILS_VERSION)
PCIUTILS_SUFFIX		:= tar.bz2
PCIUTILS_URL		:= http://ftp.kernel.org/pub/software/utils/pciutils/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_SOURCE		:= $(SRCDIR)/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_DIR		:= $(BUILDDIR)/$(PCIUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PCIUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, PCIUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PCIUTILS_PATH	:= PATH=$(CROSS_PATH)
PCIUTILS_COMPILE_ENV	:= $(CROSS_ENV)

PCIUTILS_MAKEVARS := \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	PREFIX=/usr \
	SBINDIR='\$$(PREFIX)/bin' \
	HOST=$(PTXCONF_ARCH_STRING)--linux \
	RELEASE=$(PTXCONF_KERNEL_VERSION) \
	STRIP= \
	DNS=no

ifdef PTXCONF_PCIUTILS_COMPRESS
PCIUTILS_MAKEVARS += ZLIB=yes
else
PCIUTILS_MAKEVARS += ZLIB=no
endif

$(STATEDIR)/pciutils.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pciutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pciutils)
	@$(call install_fixup,pciutils,PACKAGE,pciutils)
	@$(call install_fixup,pciutils,PRIORITY,optional)
	@$(call install_fixup,pciutils,VERSION,$(PCIUTILS_VERSION))
	@$(call install_fixup,pciutils,SECTION,base)
	@$(call install_fixup,pciutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,pciutils,DEPENDS,)
	@$(call install_fixup,pciutils,DESCRIPTION,missing)

	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/lspci)
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/setpci)
ifdef PTXCONF_PCIUTILS_COMPRESS
	@$(call install_copy, pciutils, 0, 0, 0644, -, \
		/usr/share/pci.ids.gz, n)
else
	@gunzip -c $(PCIUTILS_PKGDIR)/usr/share/pci.ids.gz > \
		$(PCIUTILS_PKGDIR)/usr/share/pci.ids
	@$(call install_copy, pciutils, 0, 0, 0644, -, \
		/usr/share/pci.ids, n)
endif

	@$(call install_finish,pciutils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pciutils_clean:
	rm -rf $(STATEDIR)/pciutils.*
	rm -rf $(PKGDIR)/pciutils_*
	rm -rf $(PCIUTILS_DIR)

# vim: syntax=make

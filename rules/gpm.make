# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_GPM) += gpm

#
# Paths and names
#
GPM_VERSION	:= 1.20.6
GPM		:= gpm-$(GPM_VERSION)
GPM_SUFFIX	:= tar.bz2
GPM_URL		:= http://unix.schottelius.org/gpm/archives/$(GPM).$(GPM_SUFFIX)
GPM_SOURCE	:= $(SRCDIR)/$(GPM).$(GPM_SUFFIX)
GPM_DIR		:= $(BUILDDIR)/$(GPM)
GPM_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GPM_SOURCE):
	@$(call targetinfo)
	@$(call get, GPM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPM_PATH     := PATH=$(CROSS_PATH)
GPM_ENV      := $(CROSS_ENV)

#
# autoconf
#
GPM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gpm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gpm)
	@$(call install_fixup, gpm,PACKAGE,gpm)
	@$(call install_fixup, gpm,PRIORITY,optional)
	@$(call install_fixup, gpm,VERSION,$(GPM_VERSION))
	@$(call install_fixup, gpm,SECTION,base)
	@$(call install_fixup, gpm,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, gpm,DEPENDS,)
	@$(call install_fixup, gpm,DESCRIPTION,missing)

	@$(call install_copy, gpm, 0, 0, 0644, -, \
		/usr/lib/libgpm.so.2.1.0)
	@$(call install_link, gpm, libgpm.so.2.1.0, /usr/lib/libgpm.so.2)
	@$(call install_link, gpm, libgpm.so.2, /usr/lib/libgpm.so)


	@$(call install_copy, gpm, 0, 0, 0755, -, \
		/usr/sbin/gpm)

	@$(call install_finish, gpm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gpm_clean:
	rm -rf $(STATEDIR)/gpm.*
	rm -rf $(PKGDIR)/gpm_*
	rm -rf $(GPM_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LSH) += lsh

#
# Paths and names
#
LSH_VERSION	:= 2.0.4
LSH		:= lsh-$(LSH_VERSION)
LSH_SUFFIX	:= tar.gz
LSH_URL		:= http://www.lysator.liu.se/~nisse/archive/$(LSH).$(LSH_SUFFIX)
LSH_SOURCE	:= $(SRCDIR)/$(LSH).$(LSH_SUFFIX)
LSH_DIR		:= $(BUILDDIR)/$(LSH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LSH_SOURCE):
	@$(call targetinfo)
	@$(call get, LSH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LSH_PATH	:= PATH=$(CROSS_PATH)
LSH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LSH_AUTOCONF := \
	$(CROSS_AUTOCONF_ROOT) \
	--sysconfdir=/etc/lsh \
	--disable-kerberos \
	--disable-pam \
	--disable-tcp-forward \
	--disable-x11-forward \
	--disable-agent-forward \
	--disable-ipv6 \
	--disable-utmp \
	--without-x \
	--without-system-argp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lsh)
	@$(call install_fixup, lsh,PACKAGE,lsh)
	@$(call install_fixup, lsh,PRIORITY,optional)
	@$(call install_fixup, lsh,VERSION,$(LSH_VERSION))
	@$(call install_fixup, lsh,SECTION,base)
	@$(call install_fixup, lsh,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, lsh,DEPENDS,)
	@$(call install_fixup, lsh,DESCRIPTION,missing)

ifdef PTXCONF_LSH_EXECUV
	@$(call install_copy, lsh, 0, 0, 0755, -, /sbin/lsh-execuv)
endif

ifdef PTXCONF_LSH_LSHD
	@$(call install_copy, lsh, 0, 0, 0755, -, /sbin/lshd)
endif

ifdef PTXCONF_LSH_SFTPD
	@$(call install_copy, lsh, 0, 0, 0755, -, /sbin/sftp-server)
endif

ifdef PTXCONF_LSH_MAKESEED
	@$(call install_copy, lsh, 0, 0, 0755, -, /bin/lsh-make-seed)
endif

ifdef PTXCONF_LSH_WRITEKEY
	@$(call install_copy, lsh, 0, 0, 0755, -, /bin/lsh-writekey)
endif

ifdef PTXCONF_LSH_KEYGEN
	@$(call install_copy, lsh, 0, 0, 0755, -, /bin/lsh-keygen)
endif
	@$(call install_finish, lsh)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lsh_clean:
	rm -rf $(STATEDIR)/lsh.*
	rm -rf $(PKGDIR)/lsh_*
	rm -rf $(LSH_DIR)

# vim: syntax=make

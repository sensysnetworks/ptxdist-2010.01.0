# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TIOBENCH) += tiobench

#
# Paths and names
#
TIOBENCH_VERSION	:= 0.3.3
TIOBENCH		:= tiobench-$(TIOBENCH_VERSION)
TIOBENCH_SUFFIX		:= tar.gz
TIOBENCH_URL		:= $(PTXCONF_SETUP_SFMIRROR)/tiobench/$(TIOBENCH).$(TIOBENCH_SUFFIX)
TIOBENCH_SOURCE		:= $(SRCDIR)/$(TIOBENCH).$(TIOBENCH_SUFFIX)
TIOBENCH_DIR		:= $(BUILDDIR)/$(TIOBENCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TIOBENCH_SOURCE):
	@$(call targetinfo)
	@$(call get, TIOBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TIOBENCH_PATH	:= PATH=$(CROSS_PATH)
TIOBENCH_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/tiobench.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/tiobench.compile:
	@$(call targetinfo)
	cd $(TIOBENCH_DIR) && $(TIOBENCH_PATH) $(MAKE) \
		CC=$(PTXCONF_GNU_TARGET)-gcc LINK=$(PTXCONF_GNU_TARGET)-gcc \
		$(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tiobench.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tiobench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tiobench)
	@$(call install_fixup, tiobench,PACKAGE,tiobench)
	@$(call install_fixup, tiobench,PRIORITY,optional)
	@$(call install_fixup, tiobench,VERSION,$(TIOBENCH_VERSION))
	@$(call install_fixup, tiobench,SECTION,base)
	@$(call install_fixup, tiobench,AUTHOR,"Juergen Beisert <jbeisert@pengutronix.de>")
	@$(call install_fixup, tiobench,DEPENDS,)
	@$(call install_fixup, tiobench,DESCRIPTION,missing)

	@$(call install_copy, tiobench, 0, 0, 0755, $(TIOBENCH_DIR)/tiotest, \
		/usr/bin/tiotest)

	@$(call install_finish, tiobench)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tiobench_clean:
	rm -rf $(STATEDIR)/tiobench.*
	rm -rf $(PKGDIR)/tiobench_*
	rm -rf $(TIOBENCH_DIR)

# vim: syntax=make

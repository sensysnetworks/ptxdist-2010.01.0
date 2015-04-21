# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#                       Marc Kleine-Budde <kleine-budde@gmx.de>
#               2005-2008 by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GCCLIBS) += gcclibs

GCCLIBS_DIR	:= $(BUILDDIR)/gcclibs

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gcclibs)
	@$(call install_fixup, gcclibs,PACKAGE,gcclibs)
	@$(call install_fixup, gcclibs,PRIORITY,optional)
	@$(call install_fixup, gcclibs,VERSION,$(shell $(CROSS_CC) -dumpversion))
	@$(call install_fixup, gcclibs,SECTION,base)
	@$(call install_fixup, gcclibs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gcclibs,DEPENDS,)
	@$(call install_fixup, gcclibs,DESCRIPTION,missing)

ifdef PTXCONF_GCCLIBS_GCC_S
	@$(call install_copy_toolchain_lib, gcclibs, libgcc_s.so, /lib)
endif

ifdef PTXCONF_GCCLIBS_CXX
	@$(call install_copy_toolchain_lib, gcclibs, libstdc++.so, /usr/lib)
endif

ifdef PTXCONF_GCCLIBS_GCJ
	@$(call install_copy_toolchain_lib, gcclibs, libgcj.so, /usr/lib)
endif

	@$(call install_finish, gcclibs)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_clean:
	rm -rf $(STATEDIR)/gcclibs.*

# vim: syntax=make

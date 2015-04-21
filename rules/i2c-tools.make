# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by Carsten Schlote
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_I2C_TOOLS) += i2c-tools

#
# Paths and names
#
I2C_TOOLS_VERSION	:= 3.0.2
I2C_TOOLS		:= i2c-tools-$(I2C_TOOLS_VERSION)
I2C_TOOLS_SUFFIX	:= tar.bz2
I2C_TOOLS_URL		:= http://dl.lm-sensors.org/i2c-tools/releases/$(I2C_TOOLS).$(I2C_TOOLS_SUFFIX)
I2C_TOOLS_SOURCE	:= $(SRCDIR)/$(I2C_TOOLS).$(I2C_TOOLS_SUFFIX)
I2C_TOOLS_DIR		:= $(BUILDDIR)/$(I2C_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(I2C_TOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, I2C_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

I2C_TOOLS_PATH	:= PATH=$(CROSS_PATH)
I2C_TOOLS_ENV 	:= $(CROSS_ENV)
I2C_TOOLS_MAKEVARS := prefix= $(CROSS_ENV_CC)

$(STATEDIR)/i2c-tools.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/i2c-tools.compile:
	@$(call targetinfo)
	cd $(I2C_TOOLS_DIR) && \
		$(I2C_TOOLS_PATH) $(MAKE) $(PARALLELMFLAGS) $(I2C_TOOLS_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i2c-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, i2c-tools)
	@$(call install_fixup, i2c-tools,PACKAGE,i2c-tools)
	@$(call install_fixup, i2c-tools,PRIORITY,optional)
	@$(call install_fixup, i2c-tools,VERSION,$(I2C_TOOLS_VERSION))
	@$(call install_fixup, i2c-tools,SECTION,base)
	@$(call install_fixup, i2c-tools,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, i2c-tools,DEPENDS,)
	@$(call install_fixup, i2c-tools,DESCRIPTION,missing)

	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /sbin/i2cdetect)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /sbin/i2cdump)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /sbin/i2cset)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /sbin/i2cget)

	@$(call install_finish, i2c-tools)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

i2c-tools_clean:
	rm -rf $(STATEDIR)/i2c-tools.*
	rm -rf $(PKGDIR)/i2c-tools_*
	rm -rf $(I2C_TOOLS_DIR)

# vim: syntax=make

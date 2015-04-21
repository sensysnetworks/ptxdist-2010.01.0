# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSON_C) += json-c

#
# Paths and names
#
JSON_C_VERSION		:= 0.9
JSON_C			:= json-c-$(JSON_C_VERSION)
JSON_C_SUFFIX		:= tar.gz
JSON_C_URL		:= http://oss.metaparadigm.com/json-c/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_SOURCE		:= $(SRCDIR)/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_DIR		:= $(BUILDDIR)/$(JSON_C)
JSON_C_LICENSE		:= MIT

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(JSON_C_SOURCE):
	@$(call targetinfo)
	@$(call get, JSON_C)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JSON_C_PATH	:= PATH=$(CROSS_PATH)
JSON_C_ENV	:= $(CROSS_ENV)

#
# autoconf
#
JSON_C_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, json-c)
	@$(call install_fixup, json-c,PACKAGE,json-c)
	@$(call install_fixup, json-c,PRIORITY,optional)
	@$(call install_fixup, json-c,VERSION,$(JSON_C_VERSION))
	@$(call install_fixup, json-c,SECTION,base)
	@$(call install_fixup, json-c,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, json-c,DEPENDS,)
	@$(call install_fixup, json-c,DESCRIPTION,missing)

	@$(call install_copy, json-c, 0, 0, 0644, -, /usr/lib/libjson.so.0.0.1)
	@$(call install_link, json-c, libjson.so.0.0.1, /usr/lib/libjson.so.0)
	@$(call install_link, json-c, libjson.so.0.0.1, /usr/lib/libjson.so)

	@$(call install_finish, json-c)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

json-c_clean:
	rm -rf $(STATEDIR)/json-c.*
	rm -rf $(PKGDIR)/json-c_*
	rm -rf $(JSON_C_DIR)

# vim: syntax=make

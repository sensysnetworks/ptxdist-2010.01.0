# -*-makefile-*-
#
# Copyright (C) 2008 by Brandon Fosdick <bfosdick@dash.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INOTIFY_TOOLS) += inotify-tools

#
# Paths and names
#
INOTIFY_TOOLS_VERSION	:= 3.13
INOTIFY_TOOLS		:= inotify-tools-$(INOTIFY_TOOLS_VERSION)
INOTIFY_TOOLS_SUFFIX	:= tar.gz
INOTIFY_TOOLS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/inotify-tools/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_SOURCE	:= $(SRCDIR)/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_DIR	:= $(BUILDDIR)/$(INOTIFY_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INOTIFY_TOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, INOTIFY_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

INOTIFY_TOOLS_PATH	:= PATH=$(CROSS_PATH)
INOTIFY_TOOLS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
INOTIFY_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inotify-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inotify-tools)
	@$(call install_fixup,inotify-tools,PACKAGE,inotify-tools)
	@$(call install_fixup,inotify-tools,PRIORITY,optional)
	@$(call install_fixup,inotify-tools,VERSION,$(INOTIFY_TOOLS_VERSION))
	@$(call install_fixup,inotify-tools,SECTION,base)
	@$(call install_fixup,inotify-tools,AUTHOR,"Brandon Fosdick <bfosdick@dash.net>")
	@$(call install_fixup,inotify-tools,DEPENDS,)
	@$(call install_fixup,inotify-tools,DESCRIPTION,missing)

	@$(call install_copy, inotify-tools, 0, 0, 0755, -, \
		/usr/bin/inotifywait)

	@$(call install_copy, inotify-tools, 0, 0, 0755, -, \
		/usr/bin/inotifywait)

	@$(call install_copy, inotify-tools, 0, 0, 0644, -, \
		/usr/lib/libinotifytools.so.0.4.1)

	@$(call install_link, inotify-tools, \
		libinotifytools.so.0.4.1, \
		/usr/lib/libinotifytools.so.0)

	@$(call install_link, inotify-tools, \
		libinotifytools.so.0.4.1, \
		/usr/lib/libinotifytools.so)

	@$(call install_finish, inotify-tools)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inotify-tools_clean:
	rm -rf $(STATEDIR)/inotify-tools.*
	rm -rf $(PKGDIR)/inotify-tools_*
	rm -rf $(INOTIFY_TOOLS_DIR)

# vim: syntax=make

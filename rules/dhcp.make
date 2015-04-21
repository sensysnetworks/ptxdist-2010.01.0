# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
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
PACKAGES-$(PTXCONF_DHCP) += dhcp

#
# Paths and names
#
DHCP_VERSION	:= 4.1.0
DHCP		:= dhcp-$(DHCP_VERSION)
DHCP_SUFFIX	:= tar.gz
DHCP_SOURCE	:= $(SRCDIR)/$(DHCP).$(DHCP_SUFFIX)
DHCP_DIR	:= $(BUILDDIR)/$(DHCP)

DHCP_URL := \
	http://ftp.isc.org/isc/dhcp/$(DHCP).$(DHCP_SUFFIX) \
	http://ftp.isc.org/isc/dhcp/dhcp-4.1-history/$(DHCP).$(DHCP_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DHCP_SOURCE):
	@$(call targetinfo)
	@$(call get, DHCP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DHCP_PATH	:= PATH=$(CROSS_PATH)
DHCP_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__dev_random=yes

#
# autoconf
#
DHCP_AUTOCONF := \
	$(CROSS_AUTOCONF_ROOT) \
	--disable-dhcpv6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dhcp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dhcp)
	@$(call install_fixup, dhcp,PACKAGE,dhcp)
	@$(call install_fixup, dhcp,PRIORITY,optional)
	@$(call install_fixup, dhcp,VERSION,$(DHCP_VERSION))
	@$(call install_fixup, dhcp,SECTION,base)
	@$(call install_fixup, dhcp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dhcp,DEPENDS,)
	@$(call install_fixup, dhcp,DESCRIPTION,missing)

ifdef PTXCONF_DHCP_SERVER
	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/sbin/dhcpd)
endif

ifdef PTXCONF_DHCP_DHCPD_CONF
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhcpd.conf)
endif

ifdef PTXCONF_DHCP_CLIENT
	@$(call install_copy, dhcp, 0, 0, 0755, /var/db)
	@$(call install_copy, dhcp, 0, 0, 0755, /var/state/dhcp )

	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/sbin/dhclient)

endif

ifdef PTXCONF_DHCP_DHCLIENT_SCRIPT
	@$(call install_alternative, dhcp, 0, 0, 0755, /etc/dhclient-script)
endif

ifdef PTXCONF_DHCP_DHCLIENT_CONF
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhclient.conf)
endif

ifdef PTXCONF_DHCP_RELAY
	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/sbin/dhcrelay)
endif

	@$(call install_finish, dhcp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dhcp_clean:
	rm -rf $(STATEDIR)/dhcp.*
	rm -rf $(PKGDIR)/dhcp_*
	rm -rf $(DHCP_DIR)

# vim: syntax=make

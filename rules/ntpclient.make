# -*-makefile-*-
#
# Copyright (C) 2003-2009 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NTPCLIENT) += ntpclient

#
# Paths and names
#
NTPCLIENT_VERSION	:= 365
NTPCLIENT		:= ntpclient_2007
NTPCLIENT_SUFFIX	:= tar.gz
NTPCLIENT_URL		:= http://doolittle.icarus.com/ntpclient/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_SOURCE	:= $(SRCDIR)/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_DIR		:= $(BUILDDIR)/$(NTPCLIENT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NTPCLIENT_SOURCE):
	@$(call targetinfo)
	@$(call get, NTPCLIENT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ntpclient.extract:
	@$(call targetinfo)
	@$(call clean, $(NTPCLIENT_DIR))
	@$(call extract, NTPCLIENT)
	@mv $(BUILDDIR)/ntpclient-2007 $(BUILDDIR)/ntpclient_2007
	@$(call patchin, NTPCLIENT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NTPCLIENT_PATH	:=  PATH=$(CROSS_PATH)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

NTPCLIENT_MAKEVARS := \
	CC="$(CROSS_CC)" \
	CPPFLAGS='$(CROSS_CPPFLAGS)' \
	LDFLAGS='$(CROSS_LDFLAGS)'

NTPCLIENT_CFLAGS :=

ifdef PTXCONF_NTPCLIENT_BUILD_DEBUG
NTPCLIENT_CFLAGS += -DENABLE_DEBUG
endif

ifdef PTXCONF_NTPCLIENT_BUILD_REPLAY_OPTION
NTPCLIENT_CFLAGS += -DENABLE_REPLAY
endif

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
NTPCLIENT_MAKEVARS += ntpclient
endif

ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
NTPCLIENT_MAKEVARS += adjtimex
endif

NTPCLIENT_MAKEVARS += CFLAGS='-O2 $(NTPCLIENT_CFLAGS)'

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ntpclient.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ntpclient.targetinstall:
	@$(call targetinfo)
	@$(call install_init, ntpclient)
	@$(call install_fixup, ntpclient,PACKAGE,ntpclient)
	@$(call install_fixup, ntpclient,PRIORITY,optional)
	@$(call install_fixup, ntpclient,VERSION,$(NTPCLIENT_VERSION))
	@$(call install_fixup, ntpclient,SECTION,base)
	@$(call install_fixup, ntpclient,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ntpclient,DEPENDS,)
	@$(call install_fixup, ntpclient,DESCRIPTION,missing)

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
	@$(call install_copy, ntpclient, 0, 0, 0755, \
		$(NTPCLIENT_DIR)/ntpclient, /usr/sbin/ntpclient)
endif
ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
	@$(call install_copy, ntpclient, 0, 0, 0755, \
		$(NTPCLIENT_DIR)/adjtimex, /sbin/adjtimex)
endif

#
# busybox init: start script
#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NTPCLIENT_STARTSCRIPT
	@$(call install_alternative, ntpclient, 0, 0, 0755, /etc/init.d/ntpclient)
ifneq ($(PTXCONF_NTPCLIENT_NTPSERVER_NAME),"")
#	# replace the @HOST@ with name of NTP server
	@$(call install_replace, ntpclient, /etc/init.d/ntpclient, \
		@HOST@, \
		"$(PTXCONF_NTPCLIENT_NTPSERVER_NAME)")
endif
endif
endif

	@$(call install_finish, ntpclient)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ntpclient_clean:
	rm -rf $(STATEDIR)/ntpclient.*
	rm -rf $(PKGDIR)/ntpclient_*
	rm -rf $(NTPCLIENT_DIR)

# vim: syntax=make

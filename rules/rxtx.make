# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RXTX) += rxtx

ifdef PTXCONF_RXTX
ifeq ($(shell test -x $(PTXCONF_SETUP_JAVA_SDK)/bin/javac || echo no),no)
    $(warning *** javac is mandatory to build rxtx)
    $(warning *** please run 'ptxdist setup' and set the path to the java sdk)
    $(error )
endif
endif

#
# Paths and names
#
RXTX_VERSION	:= 2.1-7r2
RXTX		:= rxtx-$(RXTX_VERSION)
RXTX_SUFFIX	:= zip
RXTX_URL	:= http://rxtx.qbang.org/pub/rxtx/$(RXTX).$(RXTX_SUFFIX)
RXTX_SOURCE	:= $(SRCDIR)/$(RXTX).$(RXTX_SUFFIX)
RXTX_DIR	:= $(BUILDDIR)/$(RXTX)
RXTX_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RXTX_SOURCE):
	@$(call targetinfo)
	@$(call get, RXTX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RXTX_PATH	:= PATH=$(CROSS_PATH)
RXTX_ENV 	:= \
	$(CROSS_ENV) \
	JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK) \
	CLASSPATH=$(PTXCONF_SETUP_JAVA_SDK)/jre/lib \
	CROSS_RXTX_PATH=/usr/lib
RXTX_MAKE_PAR := NO

#
# autoconf
#
RXTX_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--enable-shared \
	--enable-lockfile_server=no \
	--enable-DEBUG=no \
	--enable-liblock=no

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rxtx.install:
	@$(call targetinfo)
#
# make install of rxtx is quite broken. it doesn't refer to --prefix, as given
# priorly while configuring. Instead of that it tries to put himself in
# RXTX_PATH. Henc we deactivate the install stage here
#
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rxtx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rxtx)
	@$(call install_fixup, rxtx,PACKAGE,rxtx)
	@$(call install_fixup, rxtx,PRIORITY,optional)
	@$(call install_fixup, rxtx,VERSION,$(RXTX_VERSION))
	@$(call install_fixup, rxtx,SECTION,base)
	@$(call install_fixup, rxtx,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, rxtx,DEPENDS,)
	@$(call install_fixup, rxtx,DESCRIPTION,missing)

	@$(call install_copy, rxtx, 0, 0, 0644, \
		$(RXTX_DIR)/$(PTXCONF_GNU_TARGET)/.libs/librxtxI2C-2.1-7.so, \
		/usr/lib/librxtxI2C-2.1-7.so)
	@$(call install_link, rxtx, librxtxI2C-2.1-7.so, /usr/lib/librxtxI2C.so)


	@$(call install_copy, rxtx, 0, 0, 0644, \
		$(RXTX_DIR)/$(PTXCONF_GNU_TARGET)/.libs/librxtxParallel-2.1-7.so, \
		/usr/lib/librxtxParallel-2.1-7.so)
	@$(call install_link, rxtx, librxtxParallel-2.1-7.so, /usr/lib/librxtxParallel.so)


	@$(call install_copy, rxtx, 0, 0, 0644, \
		$(RXTX_DIR)/$(PTXCONF_GNU_TARGET)/.libs/librxtxRaw-2.1-7.so, \
		/usr/lib/librxtxRaw-2.1-7.so)
	@$(call install_link, rxtx, librxtxRaw-2.1-7.so, /usr/lib/librxtxRaw.so)


	@$(call install_copy, rxtx, 0, 0, 0644, \
		$(RXTX_DIR)/$(PTXCONF_GNU_TARGET)/.libs/librxtxRS485-2.1-7.so, \
		/usr/lib/librxtxRS485-2.1-7.so)
	@$(call install_link, rxtx, librxtxRS485-2.1-7.so, /usr/lib/librxtxRS485.so)


	@$(call install_copy, rxtx, 0, 0, 0644, \
		$(RXTX_DIR)/$(PTXCONF_GNU_TARGET)/.libs/librxtxSerial-2.1-7.so, \
		/usr/lib/librxtxSerial-2.1-7.so)
	@$(call install_link, rxtx, librxtxSerial-2.1-7.so, /usr/lib/librxtxSerial.so)
	@$(call install_link, rxtx, ../librxtxSerial-2.1-7.so, /usr/lib/classpath/librxtxSerial.so)

	@$(call install_copy, rxtx, 0, 0, 0644, $(RXTX_DIR)/RXTXcomm.jar, \
		/usr/share/java/RXTXcomm.jar)

	@$(call install_finish, rxtx)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rxtx_clean:
	rm -rf $(STATEDIR)/rxtx.*
	rm -rf $(PKGDIR)/rxtx_*
	rm -rf $(RXTX_DIR)

# vim: syntax=make

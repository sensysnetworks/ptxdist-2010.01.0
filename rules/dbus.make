# -*-makefile-*-
#
# Copyright (C) 2006 by Roland Hostettler
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS) += dbus

#
# Paths and names
#
DBUS_VERSION	:= 1.2.16
DBUS		:= dbus-$(DBUS_VERSION)
DBUS_SUFFIX	:= tar.gz
DBUS_URL	:= http://dbus.freedesktop.org/releases/dbus/$(DBUS).$(DBUS_SUFFIX)
DBUS_SOURCE	:= $(SRCDIR)/$(DBUS).$(DBUS_SUFFIX)
DBUS_DIR	:= $(BUILDDIR)/$(DBUS)
DBUS_LICENSE	:= AFLv2.1, GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DBUS_SOURCE):
	@$(call targetinfo)
	@$(call get, DBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DBUS_PATH := PATH=$(CROSS_PATH)
DBUS_ENV := $(CROSS_ENV)

#
# autoconf
#
DBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dnotify \
	--disable-doxygen-docs \
	--disable-gcov \
	--disable-kqueue \
	--disable-libaudit \
	--disable-tests \
	--disable-xml-docs \
	--enable-abstract-sockets=yes \
	--localstatedir=/var \
	--with-dbus-user=$(PTXCONF_DBUS_USER)

ifdef PTXCONF_DBUS_XML_EXPAT
DBUS_AUTOCONF += --with-xml=expat
endif
ifdef PTXCONF_DBUS_XML_LIBXML2
DBUS_AUTOCONF += --with-xml=libxml
endif

ifdef PTXCONF_DBUS_SELINUX
DBUS_AUTOCONF += --enable-selinux
else
DBUS_AUTOCONF += --disable-selinux
endif

ifdef PTXCONF_DBUS_X
DBUS_AUTOCONF += --with-x=$(SYSROOT)/usr
else
DBUS_AUTOCONF += --without-x
endif


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus)
	@$(call install_fixup,dbus,PACKAGE,dbus)
	@$(call install_fixup,dbus,PRIORITY,optional)
	@$(call install_fixup,dbus,VERSION,$(DBUS_VERSION))
	@$(call install_fixup,dbus,SECTION,base)
	@$(call install_fixup,dbus,AUTHOR,"Roland Hostettler <r.hostettler@gmx.ch>")
	@$(call install_fixup,dbus,DEPENDS,)
	@$(call install_fixup,dbus,DESCRIPTION,missing)

	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-daemon)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-cleanup-sockets)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-launch)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-monitor)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-send)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-uuidgen)

	@$(call install_copy, dbus, 0, 0, 0644, -, \
		/usr/lib/libdbus-1.so.3.4.0)
	@$(call install_link, dbus, libdbus-1.so.3.4.0, /usr/lib/libdbus-1.so.3)
	@$(call install_link, dbus, libdbus-1.so.3.4.0, /usr/lib/libdbus-1.so)

#	#
#	# create system.d and event.d directories, which are used by the configuration and startup files
#	#
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/system.d/)
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/event.d/)

#	#
#	# create session.d directory, which is needed to launch a session bus
#	#
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/session.d/)

#	#
#	# install /etc/dbus-1/system.conf config file
#	#
ifdef PTXCONF_DBUS_SYSTEM_CONF
	@$(call install_alternative, dbus, 0, 0, 0644, /etc/dbus-1/system.conf)
	@$(call install_replace, dbus, /etc/dbus-1/system.conf, @DBUS_USER@, $(PTXCONF_DBUS_USER))
endif

#	#
#	# instal /etc/dbus-1/session.conf config file
#	#
ifdef PTXCONF_DBUS_SESSION_CONF
	@$(call install_alternative, dbus, 0, 0, 0644, /etc/dbus-1/session.conf)
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_DBUS_STARTSCRIPT
	@$(call install_alternative, dbus, 0, 0, 0755, /etc/init.d/dbus)
endif
endif

	@$(call install_finish,dbus)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus_clean:
	rm -rf $(STATEDIR)/dbus.*
	rm -rf $(PKGDIR)/dbus_*
	rm -rf $(DBUS_DIR)

# vim: syntax=make

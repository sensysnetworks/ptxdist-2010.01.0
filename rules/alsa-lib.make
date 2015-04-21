# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALSA_LIB) += alsa-lib

#
# Paths and names
#
ALSA_LIB_SUFFIX		:= tar.bz2

ifdef PTXCONF_ALSA_LIB_FULL
ALSA_LIB_VERSION	:= 1.0.22
ALSA_LIB		:= alsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= \
	http://dl.ambiweb.de/mirrors/ftp.alsa-project.org/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX) \
	ftp://ftp.alsa-project.org/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_VERSION	:= 0.0.17
ALSA_LIB		:= salsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= ftp://ftp.suse.com/pub/people/tiwai/salsa-lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ALSA_LIB_SOURCE		:= $(SRCDIR)/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_DIR		:= $(BUILDDIR)/$(ALSA_LIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ALSA_LIB_SOURCE):
	@$(call targetinfo)
	@$(call get, ALSA_LIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALSA_LIB_PATH	:=  PATH=$(CROSS_PATH)
ALSA_LIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
ALSA_LIB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--enable-shared \
	--enable-fast-install \
	--enable-libtool-lock \
	--enable-symbolic-functions \
	--disable-debug \
	--disable-old-symbols \
	--disable-python \
	--with-tmpdir=/tmp \
	--with-debug=no \
	--with-libdl \
	--with-pthread \
	--with-librt \
	--with-alsa-devdir=/dev/snd \
	--with-aload-devdir=/dev \
	--with-versioned

ifdef PTXCONF_ALSA_LIB_RESMGR
ALSA_LIB_AUTOCONF += --enable-resmgr
else
ALSA_LIB_AUTOCONF += --disable-resmgr
endif

ifdef PTXCONF_ALSA_LIB_READ
ALSA_LIB_AUTOCONF += --enable-aload
else
ALSA_LIB_AUTOCONF += --disable-aload
endif

ifdef PTXCONF_ALSA_LIB_MIXER
ALSA_LIB_AUTOCONF += --enable-mixer
else
ALSA_LIB_AUTOCONF += --disable-mixer
endif

ifdef PTXCONF_ALSA_LIB_PCM
ALSA_LIB_AUTOCONF += \
	--enable-pcm \
	--with-pcm-plugins=all
else
ALSA_LIB_AUTOCONF += --disable-pcm
endif

ifdef PTXCONF_ALSA_LIB_RAWMIDI
ALSA_LIB_AUTOCONF += --enable-rawmidi
else
ALSA_LIB_AUTOCONF += --disable-rawmidi
endif

ifdef PTXCONF_ALSA_LIB_HWDEP
ALSA_LIB_AUTOCONF += --enable-hwdep
else
ALSA_LIB_AUTOCONF += --disable-hwdep
endif

ifdef PTXCONF_ALSA_LIB_SEQ
ALSA_LIB_AUTOCONF += --enable-seq
else
ALSA_LIB_AUTOCONF += --disable-seq
endif

ifdef PTXCONF_ALSA_LIB_ALISP
ALSA_LIB_AUTOCONF += --enable-alisp
else
ALSA_LIB_AUTOCONF += --disable-alisp
endif

ifndef PTXCONF_HAS_HARDFLOAT
ALSA_LIB_AUTOCONF += --with-softfloat
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_AUTOCONF += \
	--enable-everyhing \
	--enable-tlv \
	--enable-timer \
	--enable-conf \
	--enable-async \
	--enable-libasound \
	--enable-rawmidi
endif

# unhandled, yet
# --with-configdir=dir    path where ALSA config files are stored
#  --with-plugindir=dir    path where ALSA plugin files are stored
#  --with-ctl-plugins=<list>
#                          build control plugins (default = all)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-lib.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  alsa-lib)
	@$(call install_fixup, alsa-lib, PACKAGE, alsa-lib)
	@$(call install_fixup, alsa-lib, PRIORITY,optional)
	@$(call install_fixup, alsa-lib, VERSION,$(ALSA_LIB_VERSION))
	@$(call install_fixup, alsa-lib, SECTION,base)
	@$(call install_fixup, alsa-lib, AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, alsa-lib, DEPENDS,)
	@$(call install_fixup, alsa-lib, DESCRIPTION,missing)

ifdef PTXCONF_ALSA_LIB_LIGHT
	@$(call install_copy, alsa-lib, 0, 0, 0644, -, \
		/usr/lib/libsalsa.so.0.0.1)

	@$(call install_link, alsa-lib, \
		libsalsa.so.0.0.1, \
		/usr/lib/libsalsa.so.0)

	@$(call install_link, alsa-lib, \
		libsalsa.so.0.0.1, \
		/usr/lib/libsalsa.so)

	@$(call install_link, alsa-lib, \
		libsalsa.so, \
		/usr/lib/libasound.so)
endif

ifdef PTXCONF_ALSA_LIB_FULL
	@$(call install_copy, alsa-lib, 0, 0, 0644, -, \
		/usr/lib/libasound.so.2.0.0)

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so.2)

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so)

ifdef PTXCONF_ALSA_LIB_MIXER
	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/lib/alsa-lib/smixer/smixer-ac97.so)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/lib/alsa-lib/smixer/smixer-sbase.so)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/lib/alsa-lib/smixer/smixer-hda.so)
endif

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/share/alsa/alsa.conf)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/share/alsa/pcm/default.conf)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/share/alsa/cards/aliases.conf)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/share/alsa/pcm/dmix.conf)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, -, \
		/usr/share/alsa/pcm/dsnoop.conf)
endif

	@$(call install_finish, alsa-lib)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

alsa-lib_clean:
	rm -rf $(STATEDIR)/alsa-lib.*
	rm -rf $(PKGDIR)/alsa-lib_*
	rm -rf $(ALSA_LIB_DIR)

# vim: syntax=make

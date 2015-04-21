# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_MPLAYER) += mplayer

#
# Paths and names
#
MPLAYER_VERSION	:= 1.0rc2
MPLAYER		:= MPlayer-$(MPLAYER_VERSION)
MPLAYER_SUFFIX	:= tar.bz2
MPLAYER_URL	:= http://www.mplayerhq.hu/MPlayer/releases/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_SOURCE	:= $(SRCDIR)/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_DIR	:= $(BUILDDIR)/$(MPLAYER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mplayer_get: $(STATEDIR)/mplayer.get

$(STATEDIR)/mplayer.get: $(mplayer_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MPLAYER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MPLAYER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mplayer_extract: $(STATEDIR)/mplayer.extract

$(STATEDIR)/mplayer.extract: $(mplayer_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MPLAYER_DIR))
	@$(call extract, MPLAYER)
	@$(call patchin, MPLAYER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mplayer_prepare: $(STATEDIR)/mplayer.prepare

MPLAYER_PATH	:= PATH=$(CROSS_PATH)
MPLAYER_CFLGAS	:=
MPLAYER_ENV 	:=
ifdef PTXCONF_ARCH_X86
MPLAYER_CFLAGS          += -O2 -fomit-frame-pointer
MPLAYER_ENV      	+= CFLAGS='$(MPLAYER_CFLAGS)'
endif
MPLAYER_ENV 	+= CC_FOR_BUILD=$(HOSTCC) 
#
# autoconf
#
MPLAYER_AUTOCONF := \
	--disable-runtime-cpudetection \
	--enable-cross-compile \
	--cc=$(PTXCONF_GNU_TARGET)-gcc \
	--as=$(PTXCONF_GNU_TARGET)-as \
	--ar=$(PTXCONF_GNU_TARGET)-ar \
	--host-cc=$(HOSTCC) \
	--ranlib=$(PTXCONF_GNU_TARGET)-ranlib \
	--language=en \
	--target=$(PTXCONF_ARCH) \
        --with-extraincdir=$(SYSROOT)/usr/include \
        --with-extralibdir=$(SYSROOT)/usr/lib \
        --with-extraincdir=$(SYSROOT)/include \
        --with-extralibdir=$(SYSROOT)/lib \
        --extra-libs='-Wl,-rpath-link -Wl,$(strip $(SYSROOT))/usr/lib'

ifdef PTXCONF_ICONV
MPLAYER_AUTOCONF += --enable-iconv
else
MPLAYER_AUTOCONF += --disable-iconv
endif

#
# video out
#
MPLAYER_AUTOCONF += \
	--disable-vidix-internal \
	--disable-vidix-external \
	--disable-gl \
	--disable-dga2 \
	--disable-dga1 \
	--disable-vesa \
	--disable-svga \
	--disable-sdl \
	--disable-aa \
	--disable-caca \
	--disable-ggi \
	--disable-ggiwmh \
	--disable-directx \
	--disable-dxr2 \
	--disable-dxr3 \
	--disable-ivtv \
	--disable-dvb \
	--disable-dvbhead \
	--disable-mga \
	--disable-xmga \
	--disable-xvmc \
	--disable-vm \
	--disable-xinerama \
	--disable-x11 \
	--disable-xshape \
	--disable-mlib \
	--disable-3dfx \
	--disable-tdfxfb \
	--disable-s3fb \
	--disable-directfb \
	--disable-zr \
	--disable-bl \
	--disable-tdfxvid \
	--disable-xvr100 \
	--disable-tga \
	--disable-pnm \
	--disable-md5sum
#
# optional features
#
MPLAYER_AUTOCONF += \
	--disable-mencoder \
	--enable-mplayer \
	--disable-gui \
	--disable-gtk1 \
	--disable-largefiles \
	--disable-linux-devfs \
	--disable-termcap \
	--disable-termios \
	--disable-langinfo \
	--disable-lirc \
	--disable-lircc \
	--disable-joystick \
	--disable-apple-remote \
	--disable-vm \
	--disable-xf86keysym \
	--disable-radio \
	--disable-radio-capture \
	--disable-radio-v4l2 \
	--disable-radio-bsdbt848 \
	--disable-tv-bsdbt848 \
	--disable-tv-teletext \
	--disable-pvr \
	--disable-rtc \
	--disable-network \
	--disable-winsock2 \
	--disable-smb \
	--disable-live \
	--disable-nemesi \
	--disable-dvdnav \
	--disable-dvdread \
	--disable-dvdread-internal \
	--disable-libdvdcss-internal \
	--disable-cdparanoia \
	--disable-cddb \
	--disable-bitmap-font \
	--disable-freetype \
	--disable-fontconfig \
	--disable-unrarlib \
	--disable-menu \
	--disable-sortsub \
	--disable-fribidi \
	--disable-enca \
	--disable-macosx \
	--disable-maemo \
	--disable-macosx-finder-support \
	--disable-macosx-bundle \
	--disable-inet6 \
	--disable-gethostbyname2 \
	--disable-ftp \
	--disable-vstream \
	--disable-pthreads \
	--disable-w32threads \
	--disable-ass \
	--disable-rpath
#
# codecs
#
MPLAYER_AUTOCONF += \
	--disable-gif \
	--disable-png \
	--disable-jpeg \
	--disable-libcdio \
	--disable-liblzo \
	--disable-win32dll \
	--disable-qtx \
	--disable-xanim \
	--disable-real \
	--disable-xvid \
	--disable-x264 \
	--disable-libnut \
	--disable-libpostproc_a \
	--disable-libpostproc_so \
	--disable-tremor-internal \
	--disable-tremor-low \
	--disable-tremor-external \
	--disable-libvorbis \
	--disable-speex \
	--disable-theora \
	--disable-faad-external \
	--disable-faad-internal \
	--disable-faad-fixed \
	--disable-faac \
	--disable-ladspa \
	--disable-libdv \
	--disable-mad \
	--disable-toolame \
	--disable-twolame \
	--disable-xmms \
	--disable-libdca \
	--disable-mp3lib \
	--disable-liba52 \
	--disable-musepack \
	--disable-libamr_nb \
	--disable-libamr_wb

#	--disable-libavutil_a \
#	--disable-libavcodec_a \
#	--disable-libavformat_a \
#	--disable-libavutil_so \
#	--disable-libavcodec_so \
#	--disable-libavformat_so \
#	--disable-libavcodec_mpegaudio_hp \

#
# audio
#
MPLAYER_AUTOCONF += \
	--disable-alsa \
	--disable-ossaudio \
	--disable-arts \
	--disable-esd \
	--disable-polyp \
	--disable-jack \
	--disable-openal \
	--disable-nas \
	--disable-sgiaudio \
	--disable-sunaudio \
	--disable-win32waveout \
	--disable-select

#
# Advanced options:
#
MPLAYER_AUTOCONF += \
	--disable-mmx \
	--disable-mmxext \
	--disable-3dnow \
	--disable-3dnowext \
	--disable-sse \
	--disable-sse2 \
	--disable-ssse3 \
	--disable-shm \
	--disable-altivec \
	--disable-armv5te \
	--disable-armv6 \
	--disable-fastmemcpy \
	--disable-big-endian \
	--disable-debug \
	--disable-profile \
	--disable-sighandler \
	--disable-crash-debug \
	--disable-dynamic-plugins

# Use these options if autodetection fails (Options marked with (*) accept
# multiple paths separated by ':'):
#   --extra-libs=FLAGS          extra linker flags
#   --extra-libs-mplayer=FLAGS  extra linker flags for MPlayer
#   --extra-libs-mencoder=FLAGS extra linker flags for MEncoder
#   --with-extraincdir=DIR      extra header search paths in DIR (*)
#   --with-extralibdir=DIR      extra linker search paths in DIR (*)
#   --with-xvmclib=NAME         adapter-specific library name (e.g. XvMCNVIDIA)
#
#   --with-freetype-config=PATH path to freetype-config
#   --with-fribidi-config=PATH  path to fribidi-config
#   --with-glib-config=PATH     path to glib*-config
#   --with-gtk-config=PATH      path to gtk*-config
#   --with-sdl-config=PATH      path to sdl*-config
#   --with-dvdnav-config=PATH   path to dvdnav-config

#
# Configurable Video Inputs
#

ifdef PTXCONF_MPLAYER_VI_V4L1
MPLAYER_AUTOCONF += --enable-tv-v4l1
else
MPLAYER_AUTOCONF += --disable-tv-v4l1
endif

ifdef PTXCONF_MPLAYER_VI_V4L2
MPLAYER_AUTOCONF += --enable-tv-v4l2
else
MPLAYER_AUTOCONF += --disable-tv-v4l2
endif

#
# Configurable Video Outputs
#

ifdef PTXCONF_MPLAYER_VO_XV
MPLAYER_AUTOCONF += --enable-xv
else
MPLAYER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_MPLAYER_VO_X11
MPLAYER_AUTOCONF += --enable-x11
else
MPLAYER_AUTOCONF += --disable-x11
endif

ifdef PTXCONF_MPLAYER_VO_FBDEV
MPLAYER_AUTOCONF += --enable-fbdev
else
MPLAYER_AUTOCONF += --disable-fbdev
endif

# enable tv if any of the tv options are on
ifeq ($(or $(PTXCONF_MPLAYER_VI_V4L1),$(PTXCONF_MPLAYER_VI_V4L2)),)
MPLAYER_AUTOCONF += --disable-tv
else
MPLAYER_AUTOCONF += --enable-tv
endif


#
# Configurable Codecs
#
ifdef PTXCONF_MPLAYER_CODEC_MPEG2
MPLAYER_AUTOCONF += --enable-libmpeg2
else
MPLAYER_AUTOCONF += --disable-libmpeg2
endif

#
# Advanced Options
#
ifdef PTXCONF_ARCH_ARM_PXA
ifdef PTXCONF_MPLAYER_ADVANCED_PXA
MPLAYER_AUTOCONF += --enable-pxa
else
MPLAYER_AUTOCONF += --disable-pxa
endif
ifdef PTXCONF_MPLAYER_ADVANCED_IWMMXT
MPLAYER_AUTOCONF += --enable-iwmmxt
else
MPLAYER_AUTOCONF += --disable-iwmmxt
endif
else
MPLAYER_AUTOCONF += --disable-pxa --disable-iwmmxt
endif

$(STATEDIR)/mplayer.prepare: $(mplayer_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MPLAYER_DIR)/config.cache)
	cd $(MPLAYER_DIR) && \
		$(MPLAYER_PATH) $(MPLAYER_ENV) \
		./configure $(MPLAYER_AUTOCONF)
	@echo 
	@echo FIXME: this is necessary with gcc 3.4.4 which runs into OOM with -O4
	@echo
#	sed -i -e "s/[ \t]-O4[ \t]/ -O2 /g" $(MPLAYER_DIR)/config.mak
	@echo
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mplayer_compile: $(STATEDIR)/mplayer.compile

$(STATEDIR)/mplayer.compile: $(mplayer_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MPLAYER_DIR) && $(MPLAYER_ENV) $(MPLAYER_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mplayer_install: $(STATEDIR)/mplayer.install

$(STATEDIR)/mplayer.install: $(mplayer_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mplayer_targetinstall: $(STATEDIR)/mplayer.targetinstall

$(STATEDIR)/mplayer.targetinstall: $(mplayer_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mplayer)
	@$(call install_fixup, mplayer,PACKAGE,mplayer)
	@$(call install_fixup, mplayer,PRIORITY,optional)
	@$(call install_fixup, mplayer,VERSION,$(MPLAYER_VERSION))
	@$(call install_fixup, mplayer,SECTION,base)
	@$(call install_fixup, mplayer,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mplayer,DEPENDS,)
	@$(call install_fixup, mplayer,DESCRIPTION,missing)

	@$(call install_copy, mplayer, 0, 0, 0755, $(MPLAYER_DIR)/mplayer, /usr/bin/mplayer)

	@$(call install_finish, mplayer)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mplayer_clean:
	rm -rf $(STATEDIR)/mplayer.*
	rm -rf $(PKGDIR)/mplayer_*
	rm -rf $(MPLAYER_DIR)

# vim: syntax=make

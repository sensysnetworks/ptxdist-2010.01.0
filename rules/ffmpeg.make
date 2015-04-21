# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
#
#
# We provide this package
#
PACKAGES-$(PTXCONF_FFMPEG) += ffmpeg

#
# Paths and names
#
FFMPEG_VERSION	:= r12314
FFMPEG		:= ffmpeg-$(FFMPEG_VERSION)
FFMPEG_SUFFIX	:= tar.bz2
FFMPEG_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_SOURCE	:= $(SRCDIR)/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_DIR	:= $(BUILDDIR)/$(FFMPEG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ffmpeg_get: $(STATEDIR)/ffmpeg.get

$(STATEDIR)/ffmpeg.get: $(ffmpeg_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FFMPEG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FFMPEG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ffmpeg_extract: $(STATEDIR)/ffmpeg.extract

$(STATEDIR)/ffmpeg.extract: $(ffmpeg_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FFMPEG_DIR))
	@$(call extract, FFMPEG)
	@$(call patchin, FFMPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ffmpeg_prepare: $(STATEDIR)/ffmpeg.prepare

FFMPEG_PATH	:=  PATH=$(CROSS_PATH):/sbin/
FFMPEG_ENV 	:=  $(CROSS_ENV)

#
# autoconf
# Carefull, ffmpeg has a home grown configure, and not all autoconf options work!!! :-/
# for example it enables things by default and than only has a --disable-BLA option and no
# --enable-BLA option.
#
FFMPEG_AUTOCONF := --prefix=/usr
FFMPEG_AUTOCONF += --cross-prefix=$(COMPILER_PREFIX)
#FFMPEG_AUTOCONF += --cc=$(CROSS_CC)
#FFMPEG_AUTOCONF += --make=$(MAKE)
FFMPEG_AUTOCONF += --source-path=$(FFMPEG_DIR)
#FFMPEG_AUTOCONF += --build-suffix=SUFFIX
FFMPEG_AUTOCONF += --extra-cflags="$(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -L$(SYSROOT)/usr/lib"
FFMPEG_AUTOCONF += --extra-ldflags="$(CROSS_LDFLAGS) -L$(SYSROOT)/usr/lib"
FFMPEG_AUTOCONF += --extra-libs="$(CROSS_LIBS) -lm"
#FFMPEG_AUTOCONF += --enable-mingw32
#FFMPEG_AUTOCONF += --enable-mingwce
#FFMPEG_AUTOCONF += --enable-sunmlib
#FFMPEG_AUTOCONF += --disable-audio-beos

ifdef PTXCONF_ARCH_X86
 FFMPEG_AUTOCONF += --disable-altivec
 FFMPEG_AUTOCONF += --disable-iwmmxt
 ifdef PTXCONF_ARCH_X86_I386
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i386 \
	--tune=i386 \
	--disable-mmx
 endif
 ifdef PTXCONF_ARCH_X86_I486
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i486 \
	--tune=i486 \
	--disable-mmx
 endif
 ifdef PTXCONF_ARCH_X86_I586
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i386 \
	--cpu=i586 \
	--tune=i586
 endif
 ifdef PTXCONF_ARCH_X86_I686
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i386 \
	--cpu=i686 \
	--tune=i686
 endif
 ifdef PTXCONF_ARCH_X86_P2
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i386 \
	--cpu=i686 \
	--tune=pentium2
 endif
 ifdef PTXCONF_ARCH_X86_P3M
  FFMPEG_AUTOCONF += \
	--arch=x86_32 \
	--cpu=i386 \
	--cpu=i686 \
	--tune=pentium3
 endif
endif

ifdef PTXCONF_ARCH_ALPHA
FFMPEG_AUTOCONF += \
	--arch=alpha \
        --cpu=alpha \
        --disable-altivec \
        --disable-mmx \
        --disable-iwmmxt
endif

ifdef PTXCONF_ARCH_ARM
 ifdef PTXCONF_ARCH_ARM_NETX
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=arm926ej-s \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
 else
 ifdef PTXCONF_ARCH_ARM_PXA
   # FIXME not all xscales are iwmmxt
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=iwmmxt \
	--disable-altivec \
	--disable-mmx
 else
 ifdef PTXCONF_ARCH_ARM_AT91SAM926X
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=arm926ej-s \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
 else
 ifdef PTXCONF_ARCH_ARM_IMX
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=arm926ej-s \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
 else
 ifdef PTXCONF_ARCH_ARM_LPC32XX
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=arm926ej-s \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
 else
 ifdef PTXCONF_ARCH_ARM_OMAP
   FFMPEG_AUTOCONF += \
	--arch=arm \
	--cpu=cortex-a8 \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
 else
 ifdef PTXCONF_FFMPEG
 $(warning Please define the config options for this CPU type!)
 endif
 endif
 endif
 endif
 endif
 endif
 endif
endif

ifdef PTXCONF_ARCH_PPC
FFMPEG_AUTOCONF += \
	--cpu=powerpc \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
# FFMPEG_AUTOCONF += --powerpc-perf-enable
endif

ifdef PTXCONF_ARCH_M68K
FFMPEG_AUTOCONF += \
	--cpu=m68k \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_ARCH_SPARC
FFMPEG_AUTOCONF += \
	--cpu=sparc \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_ARCH_MIPS
FFMPEG_AUTOCONF += \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_ARCH_CRIS
FFMPEG_AUTOCONF += \
	--cpu=cris \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_ARCH_PARISC
FFMPEG_AUTOCONF += \
	--cpu=parisc \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_ARCH_SH
FFMPEG_AUTOCONF += \
	--cpu=sh4 \
	--disable-altivec \
	--disable-mmx \
	--disable-iwmmxt
endif

ifdef PTXCONF_FFMPEG_SHARED
FFMPEG_AUTOCONF += --enable-shared
else
FFMPEG_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_FFMPEG_STATIC
FFMPEG_AUTOCONF += --enable-static
else
FFMPEG_AUTOCONF += --disable-static
endif

ifdef PTXCONF_FFMPEG_PTHREADS
FFMPEG_AUTOCONF += --enable-pthreads
endif

ifndef PTXCONF_FFMPEG_FFSERVER
FFMPEG_AUTOCONF += --disable-ffserver
endif

ifndef PTXCONF_FFMPEG_FFPLAY
FFMPEG_AUTOCONF += --disable-ffplay
endif

ifdef PTXCONF_FFMPEG_SMALL
FFMPEG_AUTOCONF += --enable-small
endif

ifdef PTXCONF_FFMPEG_MEMALIGN_HACK
FFMPEG_AUTOCONF += --enable-memalign-hack
endif

ifndef PTXCONF_FFMPEG_STRIP
FFMPEG_AUTOCONF += --disable-strip
endif

ifdef PTXCONF_FFMPEG_GPROF
FFMPEG_AUTOCONF += --enable-gprof
endif

ifndef PTXCONF_FFMPEG_DEBUG
FFMPEG_AUTOCONF += --disable-debug
endif

ifndef PTXCONF_FFMPEG_OPTS
FFMPEG_AUTOCONF += --disable-opts
endif

ifdef PTXCONF_FFMPEG_GPL
FFMPEG_AUTOCONF += --enable-gpl
endif

ifdef PTXCONF_FFMPEG_MP3LAME
FFMPEG_AUTOCONF += --enable-mp3lame
endif

ifdef PTXCONF_FFMPEG_LIBOGG
FFMPEG_AUTOCONF += --enable-libogg
endif

ifdef PTXCONF_FFMPEG_VORBIS
FFMPEG_AUTOCONF += --enable-vorbis
endif

ifdef PTXCONF_FFMPEG_THEORA
FFMPEG_AUTOCONF += --enable-theora
endif

ifdef PTXCONF_FFMPEG_FAAD
FFMPEG_AUTOCONF += --enable-faad
endif

ifdef PTXCONF_FFMPEG_FAADBIN
FFMPEG_AUTOCONF += --enable-faadbin
endif

ifdef PTXCONF_FFMPEG_FAAC
FFMPEG_AUTOCONF += --enable-faac
endif

ifdef PTXCONF_FFMPEG_LIBGSM
FFMPEG_AUTOCONF += --enable-libgsm
endif

ifdef PTXCONF_FFMPEG_XVID
FFMPEG_AUTOCONF += --enable-xvid
endif

ifdef PTXCONF_FFMPEG_X264
FFMPEG_AUTOCONF += --enable-x264
endif

ifdef PTXCONF_FFMPEG_A52
FFMPEG_AUTOCONF += --enable-a52
endif

ifdef PTXCONF_FFMPEG_A52BIN
FFMPEG_AUTOCONF += --enable-a52bin
endif

ifdef PTXCONF_FFMPEG_DTS
FFMPEG_AUTOCONF += --enable-dts
endif

ifdef PTXCONF_FFMPEG_PP
FFMPEG_AUTOCONF += --enable-pp
endif

ifdef PTXCONF_FFMPEG_AMR_NB
FFMPEG_AUTOCONF += --enable-amr_nb
endif

ifdef PTXCONF_FFMPEG_AMR_NB_FIXED
FFMPEG_AUTOCONF += --enable-amr_nb-fixed
endif

ifdef PTXCONF_FFMPEG_AMR_WB
FFMPEG_AUTOCONF += --enable-amr_wb
endif

ifdef PTXCONF_FFMPEG_AMR_IF2
FFMPEG_AUTOCONF += --enable-amr_if2
endif

ifdef PTXCONF_FFMPEG_DC1394
FFMPEG_AUTOCONF += --enable-dc1394
endif

ifndef PTXCONF_FFMPEG_AUDIO_OSS
FFMPEG_AUTOCONF += --disable-audio-oss
endif

ifndef PTXCONF_FFMPEG_V4L
FFMPEG_AUTOCONF += --disable-v4l
endif

ifndef PTXCONF_FFMPEG_V4L2
FFMPEG_AUTOCONF += --disable-v4l2
endif

ifndef PTXCONF_FFMPEG_BKTR
FFMPEG_AUTOCONF += --disable-bktr
endif

ifndef PTXCONF_FFMPEG_DV1394
FFMPEG_AUTOCONF += --disable-dv1394
endif

ifndef PTXCONF_FFMPEG_NETWORK
FFMPEG_AUTOCONF += --disable-network
endif

ifndef PTXCONF_FFMPEG_ZLIB
FFMPEG_AUTOCONF += --disable-zlib
endif

ifndef PTXCONF_FFMPEG_SIMPLE_IDCT
FFMPEG_AUTOCONF += --disable-simple_idct
endif

ifndef PTXCONF_FFMPEG_VHOOK
FFMPEG_AUTOCONF += --disable-vhook
endif

ifndef PTXCONF_FFMPEG_MPEGAUDIO_HP
FFMPEG_AUTOCONF += --disable-mpegaudio-hp
endif

ifndef PTXCONF_FFMPEG_PROTOCOL
FFMPEG_AUTOCONF += --disable-protocols
endif

# FIXME selectivly enable/disable decoders to reduce library size

#--disable-encoder=NAME   disables encoder NAME
#--enable-encoder=NAME    enables encoder NAME
#--disable-decoder=NAME   disables decoder NAME
#--enable-decoder=NAME    enables decoder NAME
#--disable-encoders       disables all encoders
#--disable-decoders       disables all decoders
#--disable-muxers         disables all muxers
#--disable-demuxers       disables all demuxers


$(STATEDIR)/ffmpeg.prepare: $(ffmpeg_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FFMPEG_DIR)/config.cache)
	cd $(FFMPEG_DIR) && \
		$(FFMPEG_PATH) $(FFMPEG_ENV) \
		./configure $(FFMPEG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ffmpeg_compile: $(STATEDIR)/ffmpeg.compile

$(STATEDIR)/ffmpeg.compile: $(ffmpeg_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FFMPEG_DIR) && \
		$(FFMPEG_PATH) $(FFMPEG_ENV) \
		make $(FFMPEG_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ffmpeg_install: $(STATEDIR)/ffmpeg.install

$(STATEDIR)/ffmpeg.install: $(ffmpeg_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FFMPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ffmpeg_targetinstall: $(STATEDIR)/ffmpeg.targetinstall

$(STATEDIR)/ffmpeg.targetinstall: $(ffmpeg_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ffmpeg)
	@$(call install_fixup, ffmpeg,PACKAGE,ffmpeg)
	@$(call install_fixup, ffmpeg,PRIORITY,optional)
	@$(call install_fixup, ffmpeg,VERSION,$(FFMPEG_VERSION))
	@$(call install_fixup, ffmpeg,SECTION,base)
	@$(call install_fixup, ffmpeg,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, ffmpeg,DEPENDS,)
	@$(call install_fixup, ffmpeg,DESCRIPTION,missing)

	@$(call install_copy, ffmpeg, 0, 0, 0644, \
		$(FFMPEG_DIR)/libavcodec/libavcodec.so, \
		/usr/lib/libavcodec.so, n)
	@$(call install_link, ffmpeg, \
		libavcodec.so, \
		/usr/lib/libavcodec.so.51)
	@$(call install_link, ffmpeg, \
		libavcodec.so, \
		/usr/lib/libavcodec.so.51.7.0)

	@$(call install_copy, ffmpeg, 0, 0, 0644, \
		$(FFMPEG_DIR)/libavformat/libavformat.so, \
		/usr/lib/libavformat.so, n)
	@$(call install_link, ffmpeg, \
		libavformat.so, \
		/usr/lib/libavformat.so.50)
	@$(call install_link, ffmpeg, \
		libavformat.so, \
		/usr/lib/libavformat.so.50.3.0)

	@$(call install_copy, ffmpeg, 0, 0, 0644, \
		$(FFMPEG_DIR)/libavutil/libavutil.so, \
		/usr/lib/libavutil.so, n)
	@$(call install_link, ffmpeg, \
		libavutil.so, \
		/usr/lib/libavutil.so.49)
	@$(call install_link, ffmpeg, \
		libavcodec.so, \
		/usr/lib/libavutil.so.49.0.0)

ifdef PTXCONF_FFMPEG_PP
	@$(call install_copy, ffmpeg, 0, 0, 0644, \
		$(FFMPEG_DIR)/libpostproc/libpostproc.so, \
		/usr/lib/libpostproc.so, n)
	@$(call install_link, ffmpeg, \
		libpostproc.so, \
		/usr/lib/libpostproc.so.51)
	@$(call install_link, ffmpeg, \
		libpostproc.so, \
		/usr/lib/libpostproc.so.51.0.0)
endif

	@$(call install_finish, ffmpeg)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ffmpeg_clean:
	rm -rf $(STATEDIR)/ffmpeg.*
	rm -rf $(PKGDIR)/ffmpeg_*
	rm -rf $(FFMPEG_DIR)

# vim: syntax=make

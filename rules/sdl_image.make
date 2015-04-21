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
# We provide this package
#
PACKAGES-$(PTXCONF_SDL_IMAGE) += sdl_image

#
# Paths and names
#
SDL_IMAGE_VERSION	:= 1.2.6
SDL_IMAGE		:= SDL_image-$(SDL_IMAGE_VERSION)
SDL_IMAGE_SUFFIX	:= tar.gz
SDL_IMAGE_URL		:= http://www.libsdl.org/projects/SDL_image/release/$(SDL_IMAGE).$(SDL_IMAGE_SUFFIX)
SDL_IMAGE_SOURCE	:= $(SRCDIR)/$(SDL_IMAGE).$(SDL_IMAGE_SUFFIX)
SDL_IMAGE_DIR		:= $(BUILDDIR)/$(SDL_IMAGE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SDL_IMAGE_SOURCE):
	@$(call targetinfo)
	@$(call get, SDL_IMAGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL_IMAGE_PATH	:=  PATH=$(CROSS_PATH)
SDL_IMAGE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_IMAGE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-sdltest \
	--disable-jpg-shared \
	--disable-png-shared \
	--disable-tif-shared \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__BMP)-bmp \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__GIF)-gif \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__JPG)-jpg \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__LBM)-lbm \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__PCX)-pcx \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__PNG)-png \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__PNM)-pnm \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__TGA)-tga \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__TIF)-tif \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__XCF)-xcf \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__XPM)-xpm \
	--$(call ptx/endis, PTXCONF_SDL_IMAGE__XV)-xv

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl_image.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl_image)
	@$(call install_fixup, sdl_image,PACKAGE,sdl-image)
	@$(call install_fixup, sdl_image,PRIORITY,optional)
	@$(call install_fixup, sdl_image,VERSION,$(SDL_IMAGE_VERSION))
	@$(call install_fixup, sdl_image,SECTION,base)
	@$(call install_fixup, sdl_image,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, sdl_image,DEPENDS,)
	@$(call install_fixup, sdl_image,DESCRIPTION,missing)

	@$(call install_copy, sdl_image, 0, 0, 0644, -, \
		/usr/lib/libSDL_image-1.2.so.0.1.5)
	@$(call install_link, sdl_image, libSDL_image-1.2.so.0.1.5, \
		/usr/lib/libSDL_image-1.2.so.0)
	@$(call install_link, sdl_image, libSDL_image-1.2.so.0.1.5, \
		/usr/lib/libSDL_image.so.0)

	@$(call install_finish, sdl_image)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl_image_clean:
	rm -rf $(STATEDIR)/sdl_image.*
	rm -rf $(PKGDIR)/sdl_image_*
	rm -rf $(SDL_IMAGE_DIR)

# vim: syntax=make

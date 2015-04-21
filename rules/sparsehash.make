# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>


PACKAGES-$(PTXCONF_SPARSEHASH) += sparsehash

#
# Paths and names
#
SPARSEHASH_NAME		:= sparsehash
SPARSEHASH_VERSION	:= 1.5.2
SPARSEHASH		:= $(SPARSEHASH_NAME)-$(SPARSEHASH_VERSION)
SPARSEHASH_SUFFIX	:= tar.gz
SPARSEHASH_URL		:= http://google-sparsehash.googlecode.com/files/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_SOURCE	:= $(SRCDIR)/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_DIR		:= $(BUILDDIR)/$(SPARSEHASH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SPARSEHASH_SOURCE):
	@$(call targetinfo)
	@$(call get, SPARSEHASH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPARSEHASH_PATH	:=  PATH=$(CROSS_PATH)
SPARSEHASH_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SPARSEHASH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sparsehash.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sparsehash_clean:
	rm -rf $(STATEDIR)/sparsehash.*
	rm -rf $(PKGDIR)/sparsehash_*
	rm -rf $(SPARSEHASH_DIR)

# vim: syntax=make

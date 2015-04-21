# -*-makefile-*-
#
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENSC) += opensc

#
# Paths and names
#
OPENSC_VERSION	:= 0.12.1
OPENSC		:= opensc-$(OPENSC_VERSION)
OPENSC_SUFFIX		:= tar.gz
OPENSC_URL		:= http://www.opensc-project.org/files/opensc/$(OPENSC).$(OPENSC_SUFFIX)
OPENSC_SOURCE		:= $(SRCDIR)/$(OPENSC).$(OPENSC_SUFFIX)
OPENSC_DIR		:= $(BUILDDIR)/$(OPENSC)
OPENSC_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OPENSC_SOURCE):
	@$(call targetinfo)
	@$(call get, OPENSC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENSC_PATH	:= PATH=$(CROSS_PATH)
OPENSC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OPENSC_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-pcsc --disable-openct --enable-ctapi  --enable-static

#$(STATEDIR)/opensc.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(OPENSC_DIR)/config.cache)
#	cd $(OPENSC_DIR) && \
#		$(OPENSC_PATH) $(OPENSC_ENV) \
#		./configure $(OPENSC_AUTOCONF)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/opensc.compile:
#	@$(call targetinfo)
#	cd $(OPENSC_DIR) && $(OPENSC_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/opensc.install:
#	@$(call targetinfo)
#	@$(call install, OPENSC)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opensc.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  opensc)
	@$(call install_fixup, opensc,PACKAGE,opensc)
	@$(call install_fixup, opensc,PRIORITY,optional)
	@$(call install_fixup, opensc,VERSION,$(OPENSC_VERSION))
	@$(call install_fixup, opensc,SECTION,base)
	@$(call install_fixup, opensc,AUTHOR,"OpenSC Author(s)")
	@$(call install_fixup, opensc,DEPENDS,)
	@$(call install_fixup, opensc,DESCRIPTION,missing)
	@$(call install_link, opensc, libopensc.so.3.0.0,/usr/lib/libopensc.so.3)

	@$(foreach ifile, $(shell cd $(OPENSC_PKGDIR); find usr/lib -type f ), \
		$(call install_copy, opensc, 0, 0, 0644, -, /$(ifile)); \
	)
	@$(foreach ifile, $(shell cd $(OPENSC_PKGDIR); find usr/bin -type f), \
		$(call install_copy, opensc, 0, 0, 0755, -, /$(ifile)); \
	)

	@$(call install_finish, opensc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

opensc_clean:
	rm -rf $(STATEDIR)/opensc.*
	rm -rf $(PKGDIR)/opensc_*
	rm -rf $(OPENSC_DIR)

# vim: syntax=make

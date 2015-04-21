# -*-makefile-*-
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PARTED) += parted

#
# Paths and names
#
PARTED_VERSION	:= 2.2
PARTED		:= parted-$(PARTED_VERSION)
PARTED_SUFFIX		:= tar.gz
PARTED_URL		:= http://ftp.gnu.org/pub/gnu/parted/$(PARTED).$(PARTED_SUFFIX)
PARTED_SOURCE		:= $(SRCDIR)/$(PARTED).$(PARTED_SUFFIX)
PARTED_DIR		:= $(BUILDDIR)/$(PARTED)
PARTED_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PARTED_SOURCE):
	@$(call targetinfo)
	@$(call get, PARTED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PARTED_PATH	:= PATH=$(CROSS_PATH)
PARTED_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PARTED_AUTOCONF := $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/parted.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(PARTED_DIR)/config.cache)
#	cd $(PARTED_DIR) && \
#		$(PARTED_PATH) $(PARTED_ENV) \
#		./configure $(PARTED_AUTOCONF)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/parted.compile:
#	@$(call targetinfo)
#	cd $(PARTED_DIR) && $(PARTED_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/parted.install:
#	@$(call targetinfo)
#	@$(call install, PARTED)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/parted.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  parted)
	@$(call install_fixup, parted,PACKAGE,parted)
	@$(call install_fixup, parted,PRIORITY,optional)
	@$(call install_fixup, parted,VERSION,$(PARTED_VERSION))
	@$(call install_fixup, parted,SECTION,base)
	@$(call install_fixup, parted,AUTHOR,"Folks at GNU")
	@$(call install_fixup, parted,DEPENDS,)
	@$(call install_fixup, parted,DESCRIPTION,missing)

	@$(call install_copy, parted, 0, 0, 0755, $(PARTED_DIR)/parted, /sbin/parted)

	@$(call install_finish, parted)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

parted_clean:
	rm -rf $(STATEDIR)/parted.*
	rm -rf $(PKGDIR)/parted_*
	rm -rf $(PARTED_DIR)

# vim: syntax=make

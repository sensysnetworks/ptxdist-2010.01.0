# -*-makefile-*-
#
# Copyright (C) 2002      by Pengutronix e.K., Hildesheim, Germany
#               2003      by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2005-2009 by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIBC) += glibc

#
# Paths and names
#
GLIBC_VERSION	:= $(call remove_quotes,$(PTXCONF_GLIBC_VERSION))
GLIBC_LICENSE	:= GPLv2, LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glibc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glibc)
	@$(call install_fixup, glibc,PACKAGE,glibc)
	@$(call install_fixup, glibc,PRIORITY,optional)
	@$(call install_fixup, glibc,VERSION,$(GLIBC_VERSION))
	@$(call install_fixup, glibc,SECTION,base)
	@$(call install_fixup, glibc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glibc,DEPENDS,)
	@$(call install_fixup, glibc,DESCRIPTION,missing)

ifdef PTXCONF_GLIBC_LD
	@$(call install_copy_toolchain_dl, glibc, /lib)
endif

ifdef PTXCONF_GLIBC_C
	@$(call install_copy_toolchain_lib, glibc, libc.so.6)
endif

ifdef PTXCONF_GLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, glibc, libpthread.so)
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	@$(call install_copy_toolchain_lib, glibc, libthread_db.so)
endif

ifdef PTXCONF_GLIBC_RT
	@$(call install_copy_toolchain_lib, glibc, librt.so)
endif

ifdef PTXCONF_GLIBC_DL
	@$(call install_copy_toolchain_lib, glibc, libdl.so.2)
	@$(call install_link, glibc, ../../lib/libdl.so.2, /usr/lib/libdl.so)
endif

ifdef PTXCONF_GLIBC_CRYPT
	@$(call install_copy_toolchain_lib, glibc, libcrypt.so)
endif

ifdef PTXCONF_GLIBC_UTIL
	@$(call install_copy_toolchain_lib, glibc, libutil.so)
endif

ifdef PTXCONF_GLIBC_M
	@$(call install_copy_toolchain_lib, glibc, libm.so)
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	@$(call install_copy_toolchain_lib, glibc, libnss_dns.so)
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	@$(call install_copy_toolchain_lib, glibc, libnss_files.so)
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	@$(call install_copy_toolchain_lib, glibc, libnss_hesiod.so)
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	@$(call install_copy_toolchain_lib, glibc, libnss_nis.so)
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	@$(call install_copy_toolchain_lib, glibc, libnss_nisplus.so)
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	@$(call install_copy_toolchain_lib, glibc, libnss_compat.so)
endif

ifdef PTXCONF_GLIBC_RESOLV
	@$(call install_copy_toolchain_lib, glibc, libresolv.so)
endif

ifdef PTXCONF_GLIBC_NSL
	@$(call install_copy_toolchain_lib, glibc, libnsl.so)
endif

ifdef PTXCONF_GLIBC_GCONF_BASE
	@$(call install_copy, glibc, 0, 0, 0755, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/gconv-modules, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_GCONV_DEF
	@$(call install_copy_toolchain_lib, glibc, gconv/ISO8859-1.so, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/ISO8859-15.so, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_GCONV_UTF
	@$(call install_copy_toolchain_lib, glibc, gconv/UNICODE.so, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/UTF-16.so, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/UTF-32.so, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/UTF-7.so, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_GCONV_ZH
	@$(call install_copy_toolchain_lib, glibc, gconv/GBBIG5.so, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/GB18030.so, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_I18N_BIN_LOCALE
	@$(call install_copy_toolchain_usr, glibc, bin/locale)
endif

ifdef PTXCONF_GLIBC_I18N_BIN_LOCALEDEF
	@$(call install_copy_toolchain_usr, glibc, bin/localedef)
endif

ifdef PTXCONF_GLIBC_I18N_RAWDATA
	@$(call install_copy_toolchain_usr, glibc, share/i18n/charmaps/*)
	@$(call install_copy_toolchain_usr, glibc, share/i18n/locales/*)
	@$(call install_copy_toolchain_usr, glibc, share/locale/locale.alias)
endif

ifdef PTXCONF_LOCALES
	@$(call install_copy_toolchain_usr, glibc, share/locale/locale.alias)
endif

# Zonefiles are BROKEN
# 	@$(call install_copy, glibc, 0, 0, 0755, /usr/share/zoneinfo)
# 	@for target in $(GLIBC_ZONEFILES-y); do \
# 		$(call install_copy, glibc, 0, 0, 0644, \
# 		$(GLIBC_ZONEDIR)/zoneinfo/$$target, \
# 		/usr/share/zoneinfo/$$target) \
# 	done;
	@$(call install_finish, glibc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean:
	rm -rf $(STATEDIR)/glibc.*
	rm -rf $(PKGDIR)/glibc_*


# vim: syntax=make

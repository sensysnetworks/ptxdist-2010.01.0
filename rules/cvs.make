# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CVS) += cvs

#
# Paths and names
#
CVS_VERSION	:= 1.11.22
CVS		:= cvs-$(CVS_VERSION)
CVS_SUFFIX	:= tar.bz2
CVS_URL		:= ftp://ftp.gnu.org/non-gnu/cvs/source/stable/$(CVS_VERSION)/$(CVS).$(CVS_SUFFIX)
CVS_SOURCE	:= $(SRCDIR)/$(CVS).$(CVS_SUFFIX)
CVS_DIR		:= $(BUILDDIR)/$(CVS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CVS_SOURCE):
	@$(call targetinfo)
	@$(call get, CVS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CVS_PATH	:= PATH=$(CROSS_PATH)
CVS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CVS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--prefix=/usr \
	--disable-dependency-tracking \
	--enable-case-sensitivity

ifdef PTXCONF_CVS_NDBM
	CVS_AUTOCONF += --enable-cvs-ndbm
else
	CVS_AUTOCONF += --disable-cvs-ndbm
endif

ifdef PTXCONF_CVS_CLIENT
	CVS_AUTOCONF += --enable-client
else
	CVS_AUTOCONF += --disable-client
endif

ifdef PTXCONF_CVS_PSSWRD_CLIENT
	CVS_AUTOCONF += --enable-password-authenticated-client
else
	CVS_AUTOCONF += --disable-password-authenticated-client
endif

ifdef PTXCONF_CVS_SERVER
	CVS_AUTOCONF += --enable-server
else
	CVS_AUTOCONF += --disable-server
endif

ifdef PTXCONF_CVS_FLOW_CONTROL
	CVS_AUTOCONF += --enable-server-flow-control=1M,2M
else
	CVS_AUTOCONF += --disable-server-flow-control
endif

ifdef PTXCONF_CVS_ENCRYPTION
	CVS_AUTOCONF += --enable-encryption
else
	CVS_AUTOCONF += --disable-encryption
endif

ifdef PTXCONF_CVS_ROOTCOMMIT
	CVS_AUTOCONF += --enable-rootcommit
else
	CVS_AUTOCONF += --disable-rootcommit
endif

#
# if we are sure we have a tmp/ directory we
# forward cvs to use it
# If not, cvs probes at runtime
#
ifdef PTXCONF_ROOTFS_TMP
	CVS_AUTOCONF += --with-tmpdir=/tmp
endif

# missing switches yet
# --with-rsh
# --with-umask
# --with-cvs-admin-group=GROUP
#

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

#
# This is a list of files cvs will call
# when specific actions occure
#
CVS_CVSROOT_FILES := commitinfo cvsignore cvswrappers editinfo history loginfo \
	modules rcsinfo taginfo

$(STATEDIR)/cvs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cvs)
	@$(call install_fixup,cvs,PACKAGE,cvs)
	@$(call install_fixup,cvs,PRIORITY,optional)
	@$(call install_fixup,cvs,VERSION,$(CVS_VERSION))
	@$(call install_fixup,cvs,SECTION,base)
	@$(call install_fixup,cvs,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup,cvs,DEPENDS,)
	@$(call install_fixup,cvs,DESCRIPTION,missing)

ifdef PTXCONF_CVS_INETD
	@$(call install_alternative, cvs, 0, 0, 0644, /etc/inetd.conf.d/cvs, n)
ifneq ($(call remove_quotes, $(PTXCONF_CVS_SERVER_REPOSITORY)),)
#	# add info about repository's root
	@$(call install_replace, cvs, /etc/inetd.conf.d/cvs, \
		@ROOT@, \
		"--allow-root=$(PTXCONF_CVS_SERVER_REPOSITORY)" )
else
#	# use cvs' default if not otherwise specified
	@$(call install_replace, cvs, /etc/inetd.conf.d/cvs, \
		@ROOT@, )
endif
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_CVS_STARTSCRIPT
	@$(call install_alternative, cvs, 0, 0, 0755, /etc/init.d/cvs, n)
endif
endif

ifneq ($(call remove_quotes, $(PTXCONF_CVS_SERVER_REPOSITORY)),)
	@$(call install_copy, cvs, 0, 0, 0755, $(PTXCONF_CVS_SERVER_REPOSITORY))

#	#
#	# install only existing files
#	#
ifdef PTXCONF_CVS_SERVER_POPULATE_CVSROOT
	@$(call install_copy, cvs, 0, 0, 0750, \
		$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT)
	@for i in ${CVS_CVSROOT_FILES}; do \
		if [ -f $(PTXDIST_WORKSPACE)/projectroot/cvsroot/$$i ]; then \
			$(call install_copy, cvs, 0, 0,0750, \
				${PTXDIST_WORKSPACE}/projectroot/cvsroot/$$i, \
				$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT/$$i,n); \
		fi; \
	done;

	@for i in config passwd readers writers; do \
		if [ -f $(PTXDIST_WORKSPACE)/projectroot/cvsroot/$$i ]; then \
			$(call install_copy, cvs, 0, 0,0640, \
				${PTXDIST_WORKSPACE}/projectroot/cvsroot/$$i, \
				$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT/$$i,n); \
		fi; \
	done;
endif
endif

	@$(call install_copy, cvs, 0, 0, 0755, -, /usr/bin/cvs)

	@$(call install_finish,cvs)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cvs_clean:
	rm -rf $(STATEDIR)/cvs.*
	rm -rf $(PKGDIR)/cvs_*
	rm -rf $(CVS_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SUDO) += sudo

#
# Paths and names
#
SUDO_VERSION	= 1.6.9
SUDO		= sudo-$(SUDO_VERSION)
SUDO_SUFFIX	= tar.gz
SUDO_URL	= http://www.courtesan.com/sudo/dist/OLD/$(SUDO).$(SUDO_SUFFIX)
SUDO_SOURCE	= $(SRCDIR)/$(SUDO).$(SUDO_SUFFIX)
SUDO_DIR	= $(BUILDDIR)/$(SUDO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sudo_get: $(STATEDIR)/sudo.get

$(STATEDIR)/sudo.get: $(sudo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SUDO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SUDO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sudo_extract: $(STATEDIR)/sudo.extract

$(STATEDIR)/sudo.extract: $(sudo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR))
	@$(call extract, SUDO)
	@$(call patchin, SUDO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sudo_prepare: $(STATEDIR)/sudo.prepare

SUDO_PATH	=  PATH=$(CROSS_PATH)
SUDO_ENV = \
	$(CROSS_ENV) \
	sudo_cv_uid_t_len=10

#
# autoconf
#
SUDO_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-shadow \
	--enable-root-sudo \
	--disable-log-host \
	--enable-noargs-shell \
	--disable-path-info \
	--disable-sia \
	--without-AFS \
	--without-DCE \
	--without-logincap \
	--without-bsdauth \
	--without-project \
	--without-lecture \
	--with-ignore-dot \
	--without-pam

ifdef PTXCONF_SUDO__SENDMAIL
SUDO_AUTOCONF += --with-sendmail
else
SUDO_AUTOCONF += --without-sendmail
endif

#  --disable-root-mailer   Don't run the mailer as root, run as the user
#  --disable-setreuid      Don't try to use the setreuid() function
#  --disable-setresuid     Don't try to use the setresuid() function
#  --enable-shell-sets-home set $HOME to target user in shell mode
#  --with-AFS              enable AFS support
#  --with-logging          log via syslog, file, or both
#  --with-logfac           syslog facility to log with (default is "local2")
#  --with-goodpri          syslog priority for commands (def is "notice")
#  --with-badpri           syslog priority for failures (def is "alert")
#  --with-logpath          path to the sudo log file
#  --with-loglen           maximum length of a log file line (default is 80)
#  --without-mail-if-no-user do not send mail if user not in sudoers
#  --with-mail-if-no-host  send mail if user in sudoers but not for this host
#  --with-mail-if-noperms  send mail if user not allowed to run command
#  --with-mailto           who should get sudo mail (default is "root")
#  --with-mailsubject      subject of sudo mail
#  --with-passprompt       default password prompt
#  --with-badpass-message  message the user sees when the password is wrong
#  --with-fqdn             expect fully qualified hosts in sudoers
#  --with-timedir          path to the sudo timestamp dir
#  --with-sudoers-mode     mode of sudoers file (defaults to 0440)
#  --with-sudoers-uid      uid that owns sudoers file (defaults to 0)
#  --with-sudoers-gid      gid that owns sudoers file (defaults to 0)
#  --with-umask            umask with which the prog should run (default is 022)
#  --without-umask         Preserves the umask of the user invoking sudo.
#  --with-runas-default    User to run commands as (default is "root")
#  --with-exempt=group     no passwd needed for users in this group
#  --with-editor=path      Default editor for visudo (defaults to vi)
#  --with-env-editor       Use the environment variable EDITOR for visudo
#  --with-passwd-tries     number of tries to enter password (default is 3)
#  --with-timeout          minutes before sudo asks for passwd again (def is 5 minutes)
#  --with-password-timeout passwd prompt timeout in minutes (default is 5 minutes)
#  --with-tty-tickets      use a different ticket file for each tty
#  --with-insults          insult the user for entering an incorrect password
#  --with-all-insults      include all the sudo insult sets
#  --with-classic-insults  include the insults from the "classic" sudo
#  --with-csops-insults    include CSOps insults
#  --with-hal-insults      include 2001-like insults
#  --with-goons-insults    include the insults from the "Goon Show"
#  --with-ldap[=DIR]       enable LDAP support
#  --with-ldap-conf-file   path to LDAP configuration file
#  --with-ldap-secret-file path to LDAP secret pasdword file
#  --with-pc-insults       replace politically incorrect insults with less offensive ones
#  --with-secure-path      override the user's path with a built-in one
#  --without-interfaces    don't try to read the ip addr of ether interfaces
#  --with-stow             properly handle GNU stow packaging
#  --with-pic              try to use only PIC/non-PIC objects [default=use

$(STATEDIR)/sudo.prepare: $(sudo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR)/config.cache)
	cd $(SUDO_DIR) && \
		$(SUDO_PATH) $(SUDO_ENV) \
		./configure $(SUDO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sudo_compile: $(STATEDIR)/sudo.compile

$(STATEDIR)/sudo.compile: $(sudo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SUDO_DIR) && $(SUDO_ENV) $(SUDO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sudo_install: $(STATEDIR)/sudo.install

$(STATEDIR)/sudo.install: $(sudo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sudo_targetinstall: $(STATEDIR)/sudo.targetinstall

$(STATEDIR)/sudo.targetinstall: $(sudo_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  sudo)
	@$(call install_fixup, sudo,PACKAGE,sudo)
	@$(call install_fixup, sudo,PRIORITY,optional)
	@$(call install_fixup, sudo,VERSION,$(SUDO_VERSION))
	@$(call install_fixup, sudo,SECTION,base)
	@$(call install_fixup, sudo,AUTHOR,"Carsten Schlote <c.schlote\@konzeptpark.de>")
	@$(call install_fixup, sudo,DEPENDS,)
	@$(call install_fixup, sudo,DESCRIPTION,missing)

	@$(call install_copy, sudo, 0, 0, 7755, $(SUDO_DIR)/sudo, /usr/bin/sudo)
	@$(call install_link, sudo, sudo, /usr/bin/sudoedit)

	@$(call install_copy, sudo, 0, 0, 0755, \
		$(SUDO_DIR)/.libs/sudo_noexec.so, \
		/usr/libexec/sudo_noexec.so)

ifdef PTXCONF_SUDO__ETC_SUDOERS
	@$(call install_alternative, sudo, 0, 0, 0440, /etc/sudoers, n)
endif
	@$(call install_finish, sudo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sudo_clean:
	rm -rf $(STATEDIR)/sudo.*
	rm -rf $(SUDO_DIR)

# vim: syntax=make

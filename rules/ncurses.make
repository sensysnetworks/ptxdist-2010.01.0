# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NCURSES) += ncurses

#
# Paths and names
#
NCURSES_VERSION	:= 5.6
NCURSES		:= ncurses-$(NCURSES_VERSION)
NCURSES_SUFFIX	:= tar.gz
NCURSES_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_SOURCE	:= $(SRCDIR)/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_DIR	:= $(BUILDDIR)/$(NCURSES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NCURSES_SOURCE):
	@$(call targetinfo)
	@$(call get, NCURSES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NCURSES_PATH	:= PATH=$(CROSS_PATH)
NCURSES_ENV 	:= $(CROSS_ENV)

NCURSES_AUTOCONF_SHARED := \
	--disable-echo \
	--disable-nls \
	--enable-const \
	--enable-overwrite \
	--libdir=/lib \
	--with-debug \
	--with-normal \
	--with-shared \
	--without-ada \
	--without-gpm

# enable wide char support on demand only
ifdef PTXCONF_NCURSES_WIDE_CHAR
NCURSES_AUTOCONF_SHARED += --enable-widec
else
NCURSES_AUTOCONF_SHARED += --disable-widec
endif

ifdef PTXCONF_NCURSES_BIG_CORE
NCURSES_AUTOCONF_SHARED += --enable-big-core
else
NCURSES_AUTOCONF_SHARED += --disable-big-core
endif

NCURSES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(NCURSES_AUTOCONF_SHARED)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ncurses.compile:
	@$(call targetinfo)
	cd $(HOST_NCURSES_DIR)/ncurses && cp make_keys make_hash $(NCURSES_DIR)/ncurses/
	cd $(NCURSES_DIR) && $(NCURSES_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_NCURSES_WIDE_CHAR
#
# we need a tweak, to force all programs to use the wide char
# library even if they request for the non wide char library
# Done by forcing the linker to use the right library instead
#
NCURSES_LIBRARY_LIST := curses ncurses

ifdef PTXCONF_NCURSES_FORM
NCURSES_LIBRARY_LIST += form
endif
ifdef PTXCONF_NCURSES_MENU
NCURSES_LIBRARY_LIST += menu
endif
ifdef PTXCONF_NCURSES_PANEL
NCURSES_LIBRARY_LIST += panel
endif

endif

$(STATEDIR)/ncurses.install:
	@$(call targetinfo)
	@$(call install, NCURSES)

	@cp -dp -- "$(PKGDIR)/$(NCURSES)/usr/bin/"*config* "$(PTXCONF_SYSROOT_CROSS)/bin"

ifdef PTXCONF_NCURSES_WIDE_CHAR
# Note: This tweak only works if we build the application with these settings!
# Already built applications may continue to use the non wide library!
# For this, the links at runtime are required
#
	for lib in $(NCURSES_LIBRARY_LIST); do \
		echo "INPUT(-l$${lib}w)" > $(SYSROOT)/lib/lib$${lib}.so ; \
	done
	ln -sf libncurses++w.a $(SYSROOT)/lib/libncurses++.a
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_NCURSES_WIDE_CHAR
NCURSES_WIDE := w
endif

$(STATEDIR)/ncurses.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ncurses)
	@$(call install_fixup, ncurses,PACKAGE,ncurses)
	@$(call install_fixup, ncurses,PRIORITY,optional)
	@$(call install_fixup, ncurses,VERSION,$(NCURSES_VERSION))
	@$(call install_fixup, ncurses,SECTION,base)
	@$(call install_fixup, ncurses,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ncurses,DEPENDS,)
	@$(call install_fixup, ncurses,DESCRIPTION,missing)

	@$(call install_copy, ncurses, 0, 0, 0644, -, \
		/lib/libncurses$(NCURSES_WIDE).so.5.6)
	@$(call install_link, ncurses, libncurses$(NCURSES_WIDE).so.5.6, \
		/lib/libncurses$(NCURSES_WIDE).so.5)
	@$(call install_link, ncurses, libncurses$(NCURSES_WIDE).so.5.6, \
		/lib/libncurses$(NCURSES_WIDE).so)

ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncurses.so.5.6)
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncurses.so.5)
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncurses.so)
endif


ifdef PTXCONF_NCURSES_FORM
	@$(call install_copy, ncurses, 0, 0, 0644, -, \
		/lib/libform$(NCURSES_WIDE).so.5.6)
	@$(call install_link, ncurses, libform$(NCURSES_WIDE).so.5.6, \
		/lib/libform$(NCURSES_WIDE).so.5)
	@$(call install_link, ncurses, libform$(NCURSES_WIDE).so.5.6, \
		/lib/libform$(NCURSES_WIDE).so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so.5.6)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so.5)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so)
endif
endif


ifdef PTXCONF_NCURSES_MENU
	@$(call install_copy, ncurses, 0, 0, 0644, -, \
		/lib/libmenu$(NCURSES_WIDE).so.5.6)
	@$(call install_link, ncurses, libmenu$(NCURSES_WIDE).so.5.6, \
		/lib/libmenu$(NCURSES_WIDE).so.5)
	@$(call install_link, ncurses, libmenu$(NCURSES_WIDE).so.5.6, \
		/lib/libmenu$(NCURSES_WIDE).so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so.5.6)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so.5)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so)
endif
endif


ifdef PTXCONF_NCURSES_PANEL
	@$(call install_copy, ncurses, 0, 0, 0644, -, \
		/lib/libpanel$(NCURSES_WIDE).so.5.6)
	@$(call install_link, ncurses, libpanel$(NCURSES_WIDE).so.5.6, \
		/lib/libpanel$(NCURSES_WIDE).so.5)
	@$(call install_link, ncurses, libpanel$(NCURSES_WIDE).so.5.6, \
		/lib/libpanel$(NCURSES_WIDE).so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so.5.6)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so.5)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so)
endif
endif


ifdef PTXCONF_NCURSES_TERMCAP
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm-color, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm-xfree86, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt100, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt102, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt200, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/a/ansi, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/l/linux, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/s/screen, n);
endif

	@$(call install_finish, ncurses)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean:
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)
	rm -rf $(PKGDIR)/ncurses_*

# vim: syntax=make

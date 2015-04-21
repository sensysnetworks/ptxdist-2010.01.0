# -*-makefile-*-

### --- internal ---

PTX_FIXPERM_RUN    := $(STATEDIR)/fix-permissions.run

#
# only run if make goal is "world", i.e. don't run during images_world
#
ifeq ($(MAKECMDGOALS)-$(PTXCONF_FIX_PERMISSIONS)-$(PTXDIST_QUIET),world-y-)
world: $(PTX_FIXPERM_RUN)
endif

$(PTX_FIXPERM_RUN): $(PTX_PERMISSIONS) $(STATEDIR)/world.targetinstall
	@ptxd_make_fixpermissions -p "$<" -r "$(ROOTDIR)" -r "$(ROOTDIR_DEBUG)"

# vim: syntax=make

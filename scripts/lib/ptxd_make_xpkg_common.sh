#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# change permissions and ownership of files and create device nodes.
# the paths specified in the permissions file are prefixed with the
# current working directory.
#
# typically used to create dev nodes in a fakeroot environment in the
# imageing process
#
# $1: permissions file
#
ptxd_dopermissions() {
	gawk -f "${PTXDIST_LIB_DIR}/ptxd_lib_dopermissions.awk" "${@}"
}
export -f ptxd_dopermissions


#
# initialize variables needed for packaging
#
ptxd_make_xpkg_init() {
    if [ -z "${pkg_xpkg_type}" -o -z "${pkg_xpkg}" ]; then
	ptxd_bailout "'pkg_xpkg' or 'pkg_xpkg_type' undefined"
    fi

    # license
    pkg_license="${pkg_license:-unknown}"
    pkg_xpkg_license="${pkg_xpkg_license:-${pkg_license}}"
    pkg_xpkg_license_file="${ptx_state_dir}/${pkg_xpkg}.license"

    # packaging stuff
    pkg_xpkg_perms="${ptx_state_dir}/${pkg_xpkg}.perms"
    pkg_xpkg_tmp="${ptx_pkg_dir}/${pkg_xpkg}.tmp"

    "ptxd_make_${pkg_xpkg_type}_init"
}
export -f ptxd_make_xpkg_init

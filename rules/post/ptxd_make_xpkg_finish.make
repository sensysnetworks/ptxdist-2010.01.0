# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# xpkg/finish
#
# finishes packet creation
#
# $1: xpkg label
#
xpkg/finish = \
	$(call xpkg/env, $(1)) \
	ptxd_make_xpkg_finish

# vim: syntax=make

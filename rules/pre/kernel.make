# -*-makefile-*-
#
# Copyright (C) 2003, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2008 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
_version_temp		:= $(subst ., ,$(KERNEL_VERSION))
_version_temp		:= $(subst -, ,$(_version_temp))
KERNEL_VERSION_MAJOR	:= $(word 1,$(_version_temp))
KERNEL_VERSION_MINOR	:= $(word 2,$(_version_temp))
KERNEL_VERSION_MICRO	:= $(word 3,$(_version_temp))
_version_temp		:=

KERNEL_HEADERS_DIR	:= $(PTXDIST_SYSROOT_TARGET)/kernel-headers
KERNEL_HEADERS_INCLUDE_DIR := $(KERNEL_HEADERS_DIR)/include

#
# handle special compiler
#
ifdef PTXCONF_KERNEL
    ifneq ($(PTXCONF_COMPILER_PREFIX),$(PTXCONF_COMPILER_PREFIX_KERNEL))
	ifeq ($(wildcard selected_toolchain_kernel/$(PTXCONF_COMPILER_PREFIX_KERNEL)gcc),)
	    $(warning *** no 'selected_toolchain_kernel' link found. Please create a link)
	    $(warning *** 'selected_toolchain_kernel' to the bin directory of your)
	    $(warning '$(PTXCONF_COMPILER_PREFIX_KERNEL)' toolchain)
	    $(error )
	endif
	KERNEL_TOOLCHAIN_LINK := $(PTXDIST_WORKSPACE)/selected_toolchain_kernel/
    endif
endif

KERNEL_CROSS_COMPILE := $(KERNEL_TOOLCHAIN_LINK)$(PTXCONF_COMPILER_PREFIX_KERNEL)

# vim: syntax=make

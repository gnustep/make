#
#   Master/service.make
#
#   Master Makefile rules to build GNUstep-based services.
#
#   Copyright (C) 1998, 2001 Free Software Foundation, Inc.
#
#   Author:  Richard Frith-Macdonald <richard@brainstorm.co.uk>
#   Based on the makefiles by Scott Christley.
#   Author:  Nicola Pero <nicola@brainstorm.co.uk>
#
#   This file is part of the GNUstep Makefile Package.
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2
#   of the License, or (at your option) any later version.
#   
#   You should have received a copy of the GNU General Public
#   License along with this library; see the file COPYING.LIB.
#   If not, write to the Free Software Foundation,
#   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

ifeq ($(RULES_MAKE_LOADED),)
include $(GNUSTEP_MAKEFILES)/rules.make
endif

SERVICE_NAME := $(strip $(SERVICE_NAME))

internal-all:: $(SERVICE_NAME:=.all.service.variables)

internal-install:: $(SERVICE_NAME:=.install.service.variables)

internal-uninstall:: $(SERVICE_NAME:=.uninstall.service.variables)

_PSWRAP_C_FILES = $(foreach service,$(SERVICE_NAME),$($(service)_PSWRAP_FILES:.psw=.c))
_PSWRAP_H_FILES = $(foreach service,$(SERVICE_NAME),$($(service)_PSWRAP_FILES:.psw=.h))

internal-clean::
	rm -rf $(GNUSTEP_OBJ_DIR) $(_PSWRAP_C_FILES) $(_PSWRAP_H_FILES)
ifeq ($(GNUSTEP_FLATTENED),)
	rm -rf *.service/$(GNUSTEP_TARGET_LDIR)
else
	rm -rf *.service
endif

internal-distclean::
	rm -rf shared_obj static_obj shared_debug_obj shared_profile_obj \
	  static_debug_obj static_profile_obj shared_profile_debug_obj \
	  static_profile_debug_obj *.service

SERVICES_WITH_SUBPROJECTS = $(strip $(foreach service,$(SERVICE_NAME),$(patsubst %,$(service),$($(service)_SUBPROJECTS))))
ifneq ($(SERVICES_WITH_SUBPROJECTS),)
internal-clean:: $(SERVICES_WITH_SUBPROJECTS:=.clean.service.subprojects)
internal-distclean:: $(SERVICES_WITH_SUBPROJECTS:=.distclean.service.subprojects)
endif

internal-strings:: $(SERVICE_NAME:=.strings.service.variables)

$(SERVICE_NAME):
	@$(MAKE) -f $(MAKEFILE_NAME) --no-print-directory \
	            $@.all.service.variables

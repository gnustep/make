#   -*-makefile-*-
#   Instance/Documentation/gsdoc.make
#
#   Instance Makefile rules to build gsdoc documentation.
#
#   Copyright (C) 1998, 2000, 2001, 2002 Free Software Foundation, Inc.
#
#   Author:  Scott Christley <scottc@net-community.com>
#   Author: Nicola Pero <n.pero@mi.flashnet.it> 
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

# The only thing we know is that each %.gsdoc file should generate a
# %.html file.  If any of the %.gsdoc files is newer than a corresponding
# %.html file, we rebuild them all.
GSDOC_OBJECT_FILES = $(patsubst %.gsdoc,%.html,$(GSDOC_FILES))

internal-doc-all_:: $(GSDOC_OBJECT_FILES)

$(GSDOC_OBJECT_FILES): $(GSDOC_FILES)
	gsdoc $(GSDOC_FILES)

internal-doc-install_:: \
	$(GNUSTEP_DOCUMENTATION)/$(DOC_INSTALL_DIR)/$(GNUSTEP_INSTANCE)
	$(INSTALL_DATA) $(GSDOC_OBJECT_FILES) \
	  $(GNUSTEP_DOCUMENTATION)/$(DOC_INSTALL_DIR)/$(GNUSTEP_INSTANCE)
internal-doc-uninstall_:: 
	rm -f \
	  $(addprefix $(GNUSTEP_DOCUMENTATION)/$(DOC_INSTALL_DIR)/\
	    $(GNUSTEP_INSTANCE)/,$(GSDOC_OBJECT_FILES))

internal-doc-clean::
	@ -rm -f $(GSDOC_OBJECT_FILES)
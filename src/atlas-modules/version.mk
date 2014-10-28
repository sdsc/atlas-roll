PACKAGE     = atlas
CATEGORY    = applications

NAME        = $(PACKAGE)-modules_$(ROLLCOMPILER)
RELEASE     = 3
PKGROOT     = /opt/modulefiles/$(CATEGORY)/.$(ROLLCOMPILER)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No

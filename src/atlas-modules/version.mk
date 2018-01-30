PACKAGE     = atlas
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 6
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-atlas-modules_gnu,sdsc-atlas-modules_intel,sdsc-atlas-modules_pgi\nAutoProv:No
RPM.PREFIX  = $(PKGROOT)

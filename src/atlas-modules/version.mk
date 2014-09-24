NAME        = atlas-modules_$(ROLLCOMPILER)
RELEASE     = 2
PKGROOT     = /opt/modulefiles/applications/.$(ROLLCOMPILER)/atlas

VERSION_SRC = $(REDHAT.ROOT)/src/atlas/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No

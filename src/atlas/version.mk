ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = atlas_$(COMPILERNAME)
VERSION        = 3.10.2
RELEASE        = 0
PKGROOT        = /opt/atlas/$(COMPILERNAME)

SRC_SUBDIR     = atlas

SOURCE_NAME    = atlas
SOURCE_SUFFIX  = tar.bz2
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = ATLAS

LAPACK_NAME    = lapack
LAPACK_SUFFIX  = tgz
LAPACK_VERSION = 3.5.0
LAPACK_PKG     = $(LAPACK_NAME)-$(LAPACK_VERSION).$(LAPACK_SUFFIX)
LAPACK_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_BZ2_PKGS   = $(SOURCE_PKG)
TGZ_PKGS       = $(LAPACK_PKG)

RPM.EXTRAS     = AutoReq:No

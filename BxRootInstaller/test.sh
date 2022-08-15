#!/usr/bin/env bash

export BX_CACHE_DIR='/opt/swtest/BxSoftware/BxCache'
export BX_WORK_DIR='/opt/swtest/BxSoftware/BxWork'
export BX_INSTALL_BASE_DIR='/opt/swtest/BxSoftware/BxInstall'
export BX_PACKAGE_DIR='/opt/swtest/BxSoftware/BxPackage'

./root_installer \
    --package-version 6.26.06 \
    --cxx14 \
    --with-python \
    --with-xrootd --without-buildin-xrootd

exit 0

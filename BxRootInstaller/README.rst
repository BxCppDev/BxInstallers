=================================
ROOT installation 
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2022-08-15

ROOT installer for Ubuntu provided by the Bayeux
development group.

Default ROOT version: 6.26.06

Requirements
============

None

Usage
======

.. code:: bash
	  
   $ ./root_installer --help
..

Example
=======

.. code:: bash

   $ export BX_CACHE_DIR="/opt/sw/${USER}/BxCache"
   $ export BX_WORK_DIR="/opt/sw/${USER}/BxWork"
   $ export BX_INSTALL_BASE_DIR="/opt/sw/${USER}/BxInstall"
   $ export BX_PACKAGE_DIR="/opt/sw/${USER}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ ./root_installer --package-version 6.16.00
   ...
   $ tree ${BX_INSTALL_BASE_DIR}/root-6.16.00/
   ...
..


Installation on Ubuntu 22.04
============================

Run the installer:

.. code:: bash
	  
   $ ./root_installer \
      --package-version 6.26.06 \
      --cxx14 \
      --with-python \
      --with-xrootd --without-buildin-xrootd
      --cache-dir "${HOME}/.bxsoftware/cache.d" \
      --work-dir "${HOME}/.bxsoftware/work.d" \
      --install-dir "${HOME}/bxsoftware/root-6.26.06" 
..

or:

.. code:: bash

   $ export BX_CACHE_DIR='/opt/swtest/BxSoftware/BxCache'
   $ export BX_WORK_DIR='/opt/swtest/BxSoftware/BxWork'
   $ export BX_INSTALL_BASE_DIR='/opt/swtest/BxSoftware/BxInstall'
   $ export BX_PACKAGE_DIR='/opt/swtest/BxSoftware/BxPackage'
   $ ./root_installer \
      --package-version 6.26.06 \
      --cxx14 \
      --with-python \
      --with-xrootd --without-buildin-xrootd
..

Build and make a binary package
===============================

Generate a ``bxroot_6.26.06-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./root_installer.bash \
       --pkg-build \
       --pkg-maintener "bayeux@lpccaen.in2p3.fr" 
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxroot_6.26.06-1_amd64.deb
..



.. end
   

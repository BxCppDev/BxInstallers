=================================
Boost installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-09-19

Boost installer for Ubuntu provided by the Bayeux
development group.

Default Boost version: 1.69.0

Requirements
============

None.

Usage
======

.. code:: bash
	  
   $ ./boost_installer --help
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
   $ ./boost_installer --package-version 1.69.0
   ...
   $ tree ${BX_INSTALL_BASE_DIR}/boost-1.69.0/
   ...
..




.. end


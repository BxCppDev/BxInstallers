=================================
Bayeux installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-09-19

Bayeux installer for Ubuntu provided by the Bayeux
development group.

Default Bayeux version: 3.4.0

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

   $ export BX_CACHE_DIR="/tmp/${USER}/BxCache"
   $ export BX_WORK_DIR="/tmp/${USER}/BxWork"
   $ export BX_INSTALL_BASE_DIR="/tmp/${USER}/BxInstall"
   $ export BX_PACKAGE_DIR="/tmp/${USER}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ ./bayeux_installer \
       --package-version 3.4.1 \
       --no-system-boost \
       --boost-root "/scratch/ubuntu18.04/BxInstall/boost-1.69.0" \
       --with-docs \
       --with-geant4 \
       --cxx-11
     
..



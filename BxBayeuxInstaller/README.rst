=================================
Bayeux installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-02-01

Bayeux installer for Ubuntu provided by the Bayeux development group.

Default Bayeux version: 3.4.4
Supported versions: 3.4.0 3.4.1 3.4.2 3.4.3 3.4.4

Requirements
============

None.

Usage
======

.. code:: bash
	  
   $ ./bayeux_installer --help
..

Examples
========

Prerequisites
-------------

You should first setup :

* GSL >=2.4
* BxDecay0 (recommended, CMake support),
* CLHEP (>= 2.1.3, CMake support),
* Geant4 (==9.6.4) (with Geant4 dataset, CMake support),
* ROOT (==6.16.00) (CMake support).

.. code:: bash

   $ bxdecay0_setup
   $ clhep_2_1_4_2_setup
   $ g4datasets_9_6_4_setup
   $ geant4_9_6_4_setup
   $ root_6_16_00_setup					
..


Ubuntu 20.04
------------

.. code:: bash

   $ export BX_CACHE_DIR="/tmp/${USER}/BxCache"
   $ export BX_WORK_DIR="/tmp/${USER}/BxWork"
   $ export BX_INSTALL_BASE_DIR="${HOME}/sw/BxInstall"
   $ export BX_PACKAGE_DIR="/tmp/${USER}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ ./bayeux_installer \
       --package-version 3.4.2 \
       --with-docs \
       --with-tests \
       --with-bxdecay0 \
       --with-qt \
       --with-geant4 \
       --without-werror \
       --with-qt 
..


Git version
-----------

.. code:: bash

   $ ./bayeux_installer \
       --source-from-git \
       --without-tests --without-qt --without-docs --with-bxdecay0
..




With a specific non system version of Boost (>1.69)
----------------------------------------------------

.. code:: bash

   $ export BX_CACHE_DIR="/tmp/${USER}/BxCache"
   $ export BX_WORK_DIR="/tmp/${USER}/BxWork"
   $ export BX_INSTALL_BASE_DIR="${HOME}/sw/BxInstall"
   $ export BX_PACKAGE_DIR="/tmp/${USER}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ ./bayeux_installer \
       --package-version 3.4.2 \
       --no-system-boost \
       --boost-root "/scratch/BxInstall/boost-1.69.0" \
       --with-docs \
       --with-geant4 \
       --with-qt
..

.. $ ./bayeux_installer \
       --package-version 3.4.1 \
       --no-system-boost \
       --boost-root "/scratch/BxInstall/boost-1.69.0" \
       --with-docs \
       --with-geant4 \
       --with-qt \
       --no-system-qt \
       --qt5-prefix "/scratch/BxInstall/qt-5.13.2" \
       --cxx-11
     
..


.. end
   

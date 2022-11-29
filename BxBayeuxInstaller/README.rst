=================================
Bayeux installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2022-11-29

* Bayeux installer for Ubuntu provided by the Bayeux development group.
* Default Bayeux version: 3.5.3 (with scripted patches)
* Supported versions: 3.5.3
* Obsolete versions: 3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.5.0 3.5.1 3.5.2 3.5.3
* Coming soon: 3.5.4

Requirements
============

* A recent Unix/BSD/Linux based system,
* See software dependencies below.

Usage
======

.. code:: bash
	  
   $ ./bayeux_installer --help
..

Examples
========

System dependencies on Ubuntu 22.04 :
-----------------------------------------

List of system dependencies:

* make 
* ninja-build
* cmake (3.22.1)
* pkg-config 
* wget 
* g++ (11.3.0)
* libboost-all-dev  (1.74)
* libreadline-dev
* libgsl-dev (2.7.1)
* libxerces-c-dev (3.2.3)
* libcamp-dev  (0.8.4)
* libqt5core5a (5.15.3)
* libqt5gui5  
* libqt5svg5 
* libqt5svg5-dev 
* libqt5widgets5 
* qtbase5-dev
* qtbase5-dev-tools
* gnuplot-qt (5.4.2)
* gnuplot-doc 
* gnuplot-mode 
* doxygen (1.9.1)

Third party dependencies :
----------------------------

For Bayeux >= 3.5.3, you should first setup :

* BxDecay0 (>=1.1.0, CMake support),
* CLHEP (>=2.1.3, 2.1.4.2 is recommended, CMake support),
* Geant4 (==9.6.4, with Geant4 dataset, CMake support),
* ROOT (==6.16.00, 6.26.06 recommended, CMake support).

.. code:: bash

   $ bxdecay0_1_1_0_setup
   $ clhep_2_1_4_2_setup
   $ g4datasets_9_6_4_setup
   $ geant4_9_6_4_setup
   $ root_6_26_06_setup					
..


Build and install on Ubuntu 22.04:
--------------------------------------

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
       --package-version 3.5.3 \
       --with-docs \
       --with-tests \
       --with-bxdecay0 \
       --with-qt \
       --with-geant4 \
       --without-werror \
       --with-qt 
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
       --package-version 3.5.3 \
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
       --package-version 3.5.3 \
       --no-system-boost \
       --boost-root "/scratch/BxInstall/boost-1.69.0" \
       --with-docs \
       --with-geant4 \
       --with-qt
..
 

.. end
   

=================================
SNRS installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2022-05-06

SNRS installer for Ubuntu provided by the Bayeux development group.

Default SNRS version: 1.1.0
Supported versions: 1.1.0

Requirements
============

* Bayeux >= 3.5.2

Usage
======

.. code:: bash
	  
   $ ./snrs_installer --help
..

Examples
========

Prerequisites
-------------

You should first setup :

* Bayeux >= 3.5.2

.. code:: bash

   $ bayeux_3_5_2_setup					
..


Ubuntu 22.04
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
   $ ./snrs_installer --package-version 1.1.0 
..


Git version
-----------

.. code:: bash

   $ ./snrs_installer --source-from-git 
..

.. end
   

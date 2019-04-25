=================================
GEANT4 installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-04-18

GEANT4 installer for Ubuntu provided by the Bayeux
development group.

Requirements
============

1. ``bxclhep`` package  
2. ``bxg4datasets-installer`` package  


Usage
======

.. code:: bash
	  
   $ ./geant4_installer --help
..

Installation on Ubuntu 18.04
============================

Preparation
-----------

.. code:: bash

   $ clhep_setup
   $ g4datasets_setup
..

   
Installation as standard user
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ ./geant4_installer \
	  --work-dir "${HOME}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/geant4-10.5" 
   ..


2. Use the setup script:

   The ``geant4.sh`` setup script is stored
   in the ``${HOME}/bxsoftware/install/geant4-10.5/bin`` directory.
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/geant4.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ~/.bxsoftware.d/modules/geant4.bash
   ..

   To activate Geant4 from a Bash shell, do:

   .. code:: bash

      $ geant4_setup
      $ which geant4-config
   ..


Installation as root
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ sudo ./geant4_installer \
	  --system-install \
   ..


2. Use the setup script:

   The ``geant4.sh`` setup script is stored
   in the ``/usr/bin`` directory.

   To activate Geant4 from a Bash shell, do:
   
   .. code:: bash

      $ source $(geant4-config --prefix)/../bin/geant4.bash
   ..

   
Build and make a binary package
===============================

Generate a ``bxgeant4_10.5-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./geant4_installer.bash \
       --pkg-build \
       --pkg-maintener "john.doe@acme.net" 
..

Check the package:

.. code:: bash
	  
   $ dpkg -c bxgeant4_10.5-1_amd64.deb
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxgeant4_10.5-1_amd64.deb
..



   
Test Geant4 installation
========================


.. code:: bash
	  
   $ mkdir -p /tmp/${USER}/Geant4Example
   $ cd /tmp/${USER}/Geant4Example/
   $ cp -r $(geant4-config --prefix)/share/Geant4-$(geant4-config --version)/examples/basic/B1 ./
   $ cd B1
   $ mkdir -p ./_build.d
   $ cd  ./_build.d
   $ cmake ..
..


.. end
   

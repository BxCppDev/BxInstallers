=================================
CLHEP installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-04-18

CLHEP installer for Ubuntu provided by the Bayeux
development group.

Default CLHEP version: 2.4.1.0

Requirements
============

None.

Usage
======

.. code:: bash
	  
   $ ./clhep_installer --help
..

Installation on Ubuntu 18.04
============================

Personal installation
---------------------

Installation as standard user
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ ./clhep_installer \
	  --work-dir "${HOME}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/clhep-2.4.1.0" 
   ..


2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/clhep.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ~/.bxsoftware.d/modules/clhep.bash
   ..

   To activate CLHEP from a Bash shell, do:

   .. code:: bash

      $ clhep_setup
      $ which clhep-config
      $ clhep-config --version 
   ..


Installation as root
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ sudo ./clhep_installer \
	  --system-install \
   ..


2. Use the setup script:

   The ``clhep.sh`` setup script is stored
   in the ``/etc/usr/bin`` directory.

   To activate Geant4 from a Bash shell, do:
   
   .. code:: bash

      $ source $(geant4-config --prefix)/../bin/clhep.bash
   ..


   
Build and make a binary package
===============================

VERY EXPERIMENTAL

Generate a ``bxclhep_2.4.1.0-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./clhep_installer.bash \
       --pkg-build \
       --pkg-maintener "john.doe@acme.net" 
..

Check the package:

.. code:: bash
	  
   $ dpkg -c bxclhep_2.4.1.0-1_amd64.deb
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxclhep_2.4.1.0-1_amd64.deb
..



.. end

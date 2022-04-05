=================================
CLHEP installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-01-07

CLHEP installer for Ubuntu provided by the Bayeux
development group.

* Default CLHEP version: 2.4.1.0
* Supported versions: 2.1.3.1 2.1.4.2 2.4.1.0 2.4.4.0

Requirements
============

None.

Usage
======

.. code:: bash
	  
   $ ./clhep_installer --help
   $ ./clhep_installer --package-version 2.4.4.0 
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
	  --work-dir "/tmp/.bxsoftware/work.d" \
	  --install-dir "/opt/sw/bxsoftware/install/clhep-2.4.4.0" 
   ..

2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/clhep@2.4.4.0.bash`` is installed in your
   home directory. It automatically sources the setup script above.

   .. code:: bash

      $ source ~/.bxsoftware.d/modules/clhep@2.4.4.0.bash
   ..

   To activate CLHEP from a Bash shell, do:

   .. code:: bash

      $ clhep_2_4_4_0_setup
      $ which clhep-config
      $ clhep-config --version 
   ..

Installation as root
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ sudo ./clhep_installer --system-install --package-version 2.4.4.0 
   ..

2. Use the setup script:

   The ``clhep.sh`` setup script is stored
   in the ``/etc/usr/bin`` directory.

   To activate CLHEP from a Bash shell, do:
   
   .. code:: bash

      $ source $(clhep-config --prefix)/../bin/clhep.bash
   ..
   
Build and make a binary package
===============================

VERY EXPERIMENTAL

Generate a ``bxclhep_2.4.4.0-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./clhep_installer.bash \
       --pkg-build \
       --pkg-maintener "john.doe@acme.net" 
..

Check the package:

.. code:: bash
	  
   $ dpkg -c bxclhep_2.4.4.0-1_amd64.deb
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxclhep_2.4.4.0-1_amd64.deb
..


.. end

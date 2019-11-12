=================================
CAMP installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-04-22

CAMP installer for Ubuntu provided by the Bayeux
development group.

Default CAMP version: 0.8.2

Requirements
============

* Boost (>=1.38.0)

  Recommended: Boost 1.69.0

  
Usage
======

.. code:: bash
	  
   $ ./camp_installer --help
..

Installation on Ubuntu 18.04
============================

Personal installation
---------------------

Installation as standard user
-----------------------------

1. Run the installer:

   .. code:: bash

      $ boost_setup
      $ echo ${BX_BOOST_INSTALL_DIR}
      ...
      $ echo ${BX_BOOST_VERSION}
      ...
      $ ./camp_installer \
          --boost-root ${BX_BOOST_INSTALL_DIR} \
	  --work-dir "/tmp/${USER}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/camp-0.8.2"
      ...
      $ tree ${HOME}/bxsoftware/install/camp-0.8.2/
      ...
   ..


2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/camp.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ${HOME}/.bxsoftware.d/modules/camp@0.8.2.bash
   ..

   To activate CAMP from a Bash shell, do:

   .. code:: bash

      $ camp_setup
      $ echo ${BX_CAMP_INSTALL_DIR}
      $ echo ${BX_CAMP_VERSION}
   ..


Installation as root
-----------------------------

1. Run the installer:

   .. code:: bash
	  
      $ sudo ./camp_installer \
	  --system-install \
   ..


2. Use the setup script:

   The ``camp.sh`` setup script is stored
   in the ``/etc/usr/bin`` directory.

   To activate Geant4 from a Bash shell, do:
   
   .. code:: bash

      $ source $(geant4-config --prefix)/../bin/camp.bash
   ..


   
Build and make a binary package
===============================

Generate a ``bxcamp_0.8.2-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./camp_installer.bash \
       --pkg-build \
       --pkg-maintener "john.doe@acme.net" 
..

Check the package:

.. code:: bash
	  
   $ dpkg -c bxcamp_0.8.2-1_amd64.deb
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxcamp_0.8.2-1_amd64.deb
..



.. end

=================================
BxRabbitmq installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-02-03

BxRabbitmq installer for Ubuntu provided by the Bayeux
development group.

Default BxRabbitmq version: 1.0.0

Requirements
============

* CMake (>=3.3 recommended)
* Gcc (>5.4.0)
* Boost (>=1.71 recommended)

  
Usage
======

.. code:: bash
	  
   $ ./bxrabbitmq_installer --help
..

Installation on Ubuntu 18.04/20.04
==================================

Personal installation
---------------------

Installation as standard user
-----------------------------

1. Run the installer:

   .. code:: bash

      $ ./bxrabbitmq_installer \
          --boost-root /path/to/boost/installation/dir \
	  --work-dir "/tmp/${USER}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/bxrabbitmq-1.0.0"
      ...
      $ tree ${HOME}/bxsoftware/install/bxrabbitmq-1.0.0/
      ...
   ..


2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/bxrabbitmq@1.0.0.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ${HOME}/.bxsoftware.d/modules/bxrabbitmq@1.0.0.bash
   ..

   To activate BXRABBITMQ from a Bash shell, do:

   .. code:: bash

      $ bxrabbitmq_1_0_0_setup
      $ echo ${BX_BXRABBITMQ_INSTALL_DIR}
      $ echo ${BX_BXRABBITMQ_VERSION}
   ..



.. end

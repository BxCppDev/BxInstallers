=================================
BxJsontools installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-01-08

BxJsontools installer for Ubuntu provided by the Bayeux
development group.

Default BxJsontools version: 1.0.0

Requirements
============

* CMake (>=3.5)
* Gcc (>5.4.0)
* Boost (>=1.69)

  
Usage
======

.. code:: bash
	  
   $ ./bxjsontools_installer --help
..

Installation on Ubuntu 18.04/20.04
==================================

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
      $ ./bxjsontools_installer \
          --boost-root /path/to/boost/installation/dir \
	  --work-dir "/tmp/${USER}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/bxjsontools-1.0.0"
      ...
      $ tree ${HOME}/bxsoftware/install/bxjsontools-1.0.0/
      ...
   ..


2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/bxjsontools@1.0.0.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ${HOME}/.bxsoftware.d/modules/bxjsontools@1.0.0.bash
   ..

   To activate BXJSONTOOLS from a Bash shell, do:

   .. code:: bash

      $ bxjsontools_setup
      $ echo ${BX_BXJSONTOOLS_INSTALL_DIR}
      $ echo ${BX_BXJSONTOOLS_VERSION}
   ..



.. end

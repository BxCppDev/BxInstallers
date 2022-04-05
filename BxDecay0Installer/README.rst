=================================
BxDecay0 installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-01-08

BxDecay0 installer for Ubuntu provided by the Bayeux
development group.

Default BxDecay0 version: 1.0.9

Requirements
============

* GSL (>=2.4)
* Geant4 (>10.6.3, optional)

  
Usage
======

.. code:: bash
	  
   $ ./bxdecay0_installer --help
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
      $ ./bxdecay0_installer \
          --bgsl-root $(gsl-config --prefix) \
	  --work-dir "/tmp/${USER}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/install/bxdecay0-1.0.9"
      ...
      $ tree ${HOME}/bxsoftware/install/bxdecay0-1.0.9/
      ...
   ..


2. Use the setup script:
   
   A Bash setup script ``${HOME}/.bxsoftware.d/modules/bxdecay0@1.0.9.bash`` is installed in your
   home directory. It automatically source the setup script above.

   .. code:: bash

      $ source ${HOME}/.bxsoftware.d/modules/bxdecay0@1.0.9.bash
   ..

   To activate BXDECAY0 from a Bash shell, do:

   .. code:: bash

      $ bxdecay0_setup
      $ echo ${BX_BXDECAY0_INSTALL_DIR}
      $ echo ${BX_BXDECAY0_VERSION}
   ..



.. end

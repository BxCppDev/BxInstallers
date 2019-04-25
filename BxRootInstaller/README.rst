=================================
ROOT installation for Bayeux
=================================

ROOT installation for Ubuntu 18.04.

Requirements
============

None

Usage
======

.. code:: bash
	  
   $ ./root_installer --help
..

Installation on Ubuntu 18.04
============================

Personal installation
---------------------

1. Run the installer:

   .. code:: bash
	  
      $ ./root_installer \
	  --cache-dir "${HOME}/.bxsoftware/cache.d" \
	  --work-dir "${HOME}/.bxsoftware/work.d" \
	  --install-dir "${HOME}/bxsoftware/root-6.16.00" 
   ..


2. Create a setup script:

   Create a ``${HOME}/.root.bash`` setup script:

   .. code:: bash

      # -*- mode: shell-script; -*-

      function do_root_setup()
      {
        local _bx_geant4_version="2.4.1.0"
        local _bx_geant4_install_dir="${HOME}/bxsoftware/geant4-2.4.1.0"
        if [ -n "${BX_GEANT4_INSTALL_DIR}" ]; then
          echo >&2 "[warning] do_geant4_setup: GEANT4 version ${BX_GEANT4_VERSION} is already setup !"   
          return 1
        fi
        export BX_GEANT4_INSTALL_DIR="${_bx_geant4_install_dir}"
        export BX_GEANT4_VERSION="${_bx_geant4_version}"
        export PATH="${BX_GEANT4_INSTALL_DIR}/bin:${PATH}"
        export LD_LIBRARY_PATH="${BX_GEANT4_INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"
        echo >&2 "[info] do_root_setup: GEANT4 version ${_bx_geant4_version} is now setup !"
        return 0
      }
      export -f do_root_setup
      alias root_setup='do_root_setup'
   ..

   You can source it from your ``~/.bashrc`` script:

   .. code:: bash

      if [ -f  ${HOME}/.root.bash ]; then
        source ${HOME}/.root.bash
      fi
   ..

Build and make a binary package
===============================

Generate a ``bxroot_6.16.00-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./root_installer.bash \
       --pkg-build \
       --pkg-maintener "bayeux@lpccaen.in2p3.fr" 
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxroot_6.16.00-1_amd64.deb
..



.. end
   

=================================
ROOT installation 
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2021-01-07

ROOT installer for Ubuntu provided by the Bayeux
development group.

Default ROOT version: 6.16.00

Requirements
============

None

Usage
======

.. code:: bash
	  
   $ ./root_installer --help
..

Example
=======

.. code:: bash

   $ export BX_CACHE_DIR="/opt/sw/${USER}/BxCache"
   $ export BX_WORK_DIR="/opt/sw/${USER}/BxWork"
   $ export BX_INSTALL_BASE_DIR="/opt/sw/${USER}/BxInstall"
   $ export BX_PACKAGE_DIR="/opt/sw/${USER}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ ./root_installer --package-version 6.16.00
   ...
   $ tree ${BX_INSTALL_BASE_DIR}/root-6.16.00/
   ...
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
        local _bx_root_version="6.16.0"
        local _bx_root_install_dir="${HOME}/bxsoftware/root-6.16.0"
        if [ -n "${BX_ROOT_INSTALL_DIR}" ]; then
          echo >&2 "[warning] do_root_setup: ROOT version ${BX_ROOT_VERSION} is already setup !"   
          return 1
        fi
        export BX_ROOT_INSTALL_DIR="${_bx_root_install_dir}"
        export BX_ROOT_VERSION="${_bx_root_version}"
        export PATH="${BX_ROOT_INSTALL_DIR}/bin:${PATH}"
        export LD_LIBRARY_PATH="${BX_ROOT_INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"
        echo >&2 "[info] do_root_setup: ROOT version ${_bx_root_version} is now setup !"
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
   

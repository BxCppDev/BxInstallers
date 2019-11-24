=================================
Qt installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-11-24

Qt installer for Ubuntu provided by the Bayeux
development group.

Default Qt version: 5.13.2

Requirements
============

Please have a look at the ``qt_installer_set_system_dependencies`` function
in the ``qt_installer`` script to make an idea about required packages
on the Ubuntu system.

  
Usage
======

.. code:: bash
	  
   $ ./qt_installer --help
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
   $ ./qt_installer [--package-version 5.13.2]
   ...
   $ tree ${BX_INSTALL_BASE_DIR}/qt-5.13.2/
   ...
..

Once installed
--------------

#. Use the setup script:

   .. code:: bash

      $ source ${HOME}/.bxsoftware.d/modules/qt@5.13.2.bash
   ..

#. Setup Qt in your current shell:
   
   .. code:: bash

      $ qt_setup 
      $ pkg-config --exists Qt5Core
      $ echo $?
      0
      $ pkg-config --variable=prefix Qt5Core
      ...
      $ pkg-config --modversion Qt5Core
      5.13.2
   ..


   
.. end

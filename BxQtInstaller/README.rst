=================================
Qt installation
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-11-24

Qt installer for Ubuntu provided by the Bayeux
development group.

Default Qt version: 5.13.2 (experimental!!!)

Requirements
============

Please have a look at the ``qt_installer_set_system_dependencies`` function
in the ``qt_installer`` script to make an idea about required packages
on the Ubuntu system.


Aims to install the following Qt5 components:

- libqt5core (Bayeux/Geant4 GUI layer, as in /usr/lib/x86_64-linux-gnu/libQt5Core.so)
- libqt5gui (Bayeux/Geant4 GUI layer, as in /usr/lib/x86_64-linux-gnu/libQt5Gui.so)
- libqt5widgets (Bayeux/Geant4 GUI layer, as in /usr/lib/x86_64-linux-gnu/libQt5Widgets.so)
- libqt5svg (Bayeux GUI layer ?, as in /usr/lib/x86_64-linux-gnu/libQt5Svg.so)
- libqt5opengl (Geant4 GUI layer, as in /usr/lib/x86_64-linux-gnu/libQt5OpenGL.so)
- libqt5printsupport (Geant4 GUI layer, as in /usr/lib/x86_64-linux-gnu/libQt5PrintSupport.so)
  
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

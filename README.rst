===================================
BxInstallers
===================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-09-19


BxInstallers  provides some  build/install scripts  for semi-automated
installation of  some software libraries  of interest. This  is useful
for testing, mostly on Ubuntu Linux.

List of supported software libraries
====================================

* ``BxQtInstaller`` : Installer for the Qt library (new)
* ``BxBoostInstaller`` : Installer for the Boost library
* ``BxCampInstaller`` : Installer for the CAMP library
* ``BxClhepInstaller`` : Installer for the CLHEP C++ library
* ``BxGeant4DatasetsInstaller`` : Installer for the GEANT4 datasets
* ``BxGeant4Installer`` : Installer for the GEANT4 Simulation Toolkit
* ``BxRootInstaller`` : Installer for the ROOT library
* ``BxBayeuxInstaller`` : Installer for the Bayeux library
* ``BxProtobuf`` : Installer for the Google Protocol Buffers library

  Protobuf's Java support is not possible  yet because of a bug in the
  installation                                                    (see
  https://github.com/protocolbuffers/protobuf/issues/4269).


Description
====================================

BxInstallers uses a set of  conventional directories used to build and
install libraries:

* The *cache*  directory is  the directory  where source  tarballs are
  downloaded.  By default, it is ``${HOME}/bxsoftware/_cache.d`` for a
  standard      user      (without     root      proviledges)      and
  ``/var/bxsoftware/cache.d`` for the root user.
* The  *work* directory  is used  to  host build  directories for  the
  installation    of    the    software.    By    default,    it    is
  ``${HOME}/bxsoftware/_work.d``  for a  standard  user (without  root
  proviledges) and ``/var/bxsoftware/work.d`` for the root user.
* The *installation* base directory is the installation base directory
  for    the    installed    software.      By    default,    it    is
  ``${HOME}/bxsoftware/install``  for a  standard  user (without  root
  proviledges) and ``/opt/bxsoftware/install`` for the root user.
* The *package*  directory is the  directory where to  store generated
  Debian        packages.        By        default,       it        is
  ``${HOME}/bxsoftware/_package.d`` for a  standard user (without root
  proviledges) and ``/var/bxsoftware/package.d`` for the root user.

These  directories  may need  a  huge  amount  of free  storage  space
(several GB).
 
BxInstallers supports  a few  environment variables to  locate working
directories used to build and install libraries:

* ``BX_CACHE_DIR`` : overrides the default cache directory.
* ``BX_WORK_DIR`` : overrides the default work directory.
* ``BX_INSTALL_BASE_DIR``  : overrides  the default  installation base
  directory.
* ``BX_PACKAGE_DIR``  :  overrides  the  package  directory  to  store
  generated Debian packages.
 
Example:

.. code:: shell

   $ export BX_BASE_DIR="/opt/sw/${USER}"
   $ export BX_CACHE_DIR="${BX_BASE_DIR}/BxCache"
   $ export BX_WORK_DIR="${BX_BASE_DIR}/BxWork"
   $ export BX_INSTALL_BASE_DIR="${BX_BASE_DIR}/BxInstall"
   $ export BX_PACKAGE_DIR="${BX_BASE_DIR}/BxPackage"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_PACKAGE_DIR}
   $ cd BxBoostInstaller/
   $ ./boost_installer --package-version 1.69.0 
   $ cd ../BxCampInstaller/
   $ ./camp_installer --boost-root "${BX_INSTALL_BASE_DIR}/boost-1.69.0" 
   $ cd ../BxClhepInstaller/
   $ ./clhep_installer --package-version "2.1.3.1"
   $ cd ../BxQtInstaller/
   $ ./qt_installer --package-version 5.13.2 
..




.. end
   

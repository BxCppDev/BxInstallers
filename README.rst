===================================
BxInstallers
===================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2022-04-05


BxInstallers (https://github.com/BxCppDev/BxInstallers)  provides some
build/install/setup  shell scripts  for an  automated installation  of
some  software  libraries of  interest  used  in  the context  of  the
development and use of the Bayeux library.

It is mainly useful for  testing and tuning the installation procedure
of some  third party software I  need, mostly on Ubuntu  Linux (18.04,
20.04,  22.04 coming  soon), but  it may  work on  CentOS (not  really
tested).

BxInstallers does not aim to  compete with industrial strength package
management systems like Spack or Homebrew/Linuxbrew, nor apt or yum. I
just consider this  tool as well adapted to *my*  needs in the context
of *my* projects,  *my* computer and the data/computing  centers I use
in my daily work.

The system is designed to allow the parallel installation and usage of
different  versions  of  a  given software  package,  using  different
build/installation paths and  distinct setup scripts. It is  up to the
user  to  properly create  some  high-level  setup scripts  that  will
activates the correct software stack with the proper dependency chain.

Use it at your own risk !

François Mauger, Université de Caen Normandie


.. contents::

BxInstallers tools
=====================

Get BxInstallers
---------------------

Clone the BxInstallers' Git repository on your system :

.. code:: bash

   $ cd ${HOME} # or wherever you want to copy BxInstallers' scripts
   $ git clone https://github.com/BxCppDev/BxInstallers 
   $ cd BxInstallers/
   $ less README.rst
..

Installation
------------------

As  a  helper package  to  build  and  install third  party  software,
BxInstallers comes with some useful scripts that can be reused in some
other context.  It  is thus possible to install theses  tools and make
them available from other tools.

.. code:: bash

   $ mkdir _build.d
   $ cd _build.d
   $ cmake -DCMAKE_INSTALL_PREFIX="/opt/sw/bxinstallers" ..
   $ make install
..


Setup the BxInstaller scripts
--------------------------------

Put the following line in your Bash startup script:

.. code:: bash

   export PATH="/opt/sw/bxinstallers/bin:${PATH}"
..

Build a skeleton installer
---------------------------

Assuming a package ``Foo`` is published as a source archive (typically
as ``foo-@version@.tar.gz``)  and build via  CMake, it is  possible to
build a skeleton of a build/install script for this package:

.. code:: bash

   $ bxinstallers-mkskel --owner "SuperNEMO-DBD" --archive-pattern "Foo-v@PKGVERSION@.tar.gz" "Foo" "/tmp/FooInstaller"
..

This  creates  the  ``/tmp/FooInstaller`` directory  with  a  skeleton
``foo_installer``   Bash  script   and  a   few  additional   resource
files.  Then the  ``foo_installer`` should  be adapted  to be  able to
download, configure, build and install the Foo package in some standard
location on your system (based on the env. var. ``BX_INSTALL_BASE_DIR``).

Typically, items to be modified are:

- the original repository where the source archive can be downloaded.
  Example: ``https://ftp.gnu.org/gnu/gsl/``
- for a GitHub repository, it is possible to specify the *owner* or *group* identifier in such a way
  the URL of the repo can be automatocally built:
  "https://github.com/@ownerName@/@packageName@/archive/"	
- the   pattern   of   the   remote  archive   filename.   Example   :
  ``"foo-@PKGVERSION@.tar.gz"``   where   the   ``"@PKGVERSION@"``   will   be
  automatically  replaced  by  the  requested version  string  of  the
  package

Once adapted to the build constraints of the package, the ``foo_installer``  script
can be used to configure, build and finally install the package.
  
.. code:: bash
	  
   $ cd /tmp/FooInstaller
   $ ./snrs_installer --help
   $ ./snrs_installer --rebuild --package-version 1.1 --with-ninja
..

A setup Bash script ``foo@.1.1.bash`` is also generated.
It must be saved in some specific location for
configuration files and sourced from a startup script.


List of supported software libraries
====================================

* ``BxQtInstaller`` : Installer for the Qt library (new and experimental)
* ``BxBoostInstaller`` : Installer for the Boost library
* ``BxCampInstaller`` : Installer for the CAMP library
* ``BxClhepInstaller`` : Installer for the CLHEP C++ library
* ``BxGeant4DatasetsInstaller`` : Installer for the GEANT4 datasets
* ``BxGeant4Installer`` : Installer for the GEANT4 Simulation Toolkit
* ``BxRootInstaller`` : Installer for the ROOT library
* ``BxDecay0Installer`` : Installer for the BxDecay0 library
* ``BxBayeuxInstaller`` : Installer for the Bayeux library
* ``BxProtobuftoolsInstaller`` : Installer for the BxProtocoltools library
* ``BxJsontoolsInstaller`` : Installer for the BxJsontools library
* ``BxRabbitmqInstaller`` : Installer for the BxRabbitmq library

..
     Protobuf's Java support is not possible  yet because of a bug in the
     installation                                                    (see
.. https://github.com/protocolbuffers/protobuf/issues/4269).

.. * ``BxProtobufInstaller`` : Installer for the Google Protocol Buffers library


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
* The  *configuration*  base  directory   is  the  directory  for  the
  configuration scripts associated  to installed software (*modules*).
  By default, it is  ``${HOME}/bxsoftware/config`` for a standard user
  (without  root proviledges)  and ``/opt/bxsoftware/config``  for the
  root user.
* The  (experimental) *package*  directory is  the directory  where to
  store   generated    Debian   packages.     By   default,    it   is
  ``${HOME}/bxsoftware/_package.d`` for a  standard user (without root
  proviledges) and ``/var/bxsoftware/package.d`` for the root user.

These  directories  may need  a  huge  amount  of free  storage  space
(several GB) because some third party software packages are really big
(ROOT,  Geant4  and  associated  datasets...) and  also  the  building
process uses quite a large amount  of storage.  Please make sure you
can find such a large space on your disks. It is probably a bad idea to install
the software stack in your home directory.
 
BxInstallers supports  a few  environment variables to  locate working
directories used to build and install libraries:

* ``BX_CACHE_DIR`` : overrides the default cache directory (for downloading).
* ``BX_WORK_DIR`` : overrides the default work directory (for building).
* ``BX_INSTALL_BASE_DIR``  : overrides  the default  installation base
  directory (for final installation).
* ``BX_CONFIG_DIR``  : overrides  the default  configuration
  directory (for configuration scripts).
* ``BX_PACKAGE_DIR``  (optional,  for  experts only,  experimental)  :
  overrides the package directory to store generated Debian packages.


Each supported software package is associated to specific installation
script which should, in principle, download the source archive (or the
git repo)  from the proper location  on the web, unpack  it, configure
it, compile  it from the  working directory  then install it.  A setup
shell script is also generated for further activation by the user.

If some extra system packages  are required, some ``apt`` commands are
run on Ubuntu before the build stage (need some *sudo* access).



  
**Example:**

#. Prepare your environment (here we  do not consider access modes for
   simplicity):

   .. code:: shell

      $ mkdir -p /opt/sw/BxSoftware
      $ export BX_CACHE_DIR="/opt/sw/BxSoftware/BxCache"
      $ export BX_WORK_DIR="/opt/sw/BxSoftware/BxWork"
      $ export BX_INSTALL_BASE_DIR="/opt/sw/BxSoftware/BxInstall"
      $ export BX_CONFIG_DIR="/opt/sw/BxSoftware/BxConfig"
      $ mkdir -p ${BX_CACHE_DIR}
      $ mkdir -p ${BX_WORK_DIR}
      $ mkdir -p ${BX_INSTALL_BASE_DIR}
      $ mkdir -p ${BX_CONFIG_DIR}
   ..

   We recommend to put the following lines in your ``~/.bashrc`` startup script:

   .. code:: shell

      $ export BX_CACHE_DIR="/opt/sw/BxSoftware/BxCache"
      $ export BX_WORK_DIR="/opt/sw/BxSoftware/BxWork"
      $ export BX_INSTALL_BASE_DIR="/opt/sw/BxSoftware/BxInstall"
      $ export BX_CONFIG_DIR="/opt/sw/BxSoftware/BxConfig"
   ..

   That will make available the working paths used to build and run the Bayeux software stack.

#. Install some software packages:

   .. code:: shell
   
      $ cd BxBoostInstaller/
      $ ./boost_installer --package-version 1.71.0 
      $ cd ../BxCampInstaller/
      $ ./camp_installer 
      $ cd ../BxClhepInstaller/
      $ ./clhep_installer --package-version "2.1.3.1"
      $ cd ../BxRootInstaller/
      $ ./root_installer --package-version 6.16.00 
   ..


.. raw:: pdf

   PageBreak
..
	 
Ubuntu 20.04
==============

This section illustrates  a typical configure-build-installation-setup
procedure for the Bayeux library and  all its dependencies on a Ubuntu
20.04 LTS system. We assume that *Bash* is the default shell.

We also assume that you are in the sudoers or equivalent to allow some
system package installation when needed.

We  recommend  not  to  use  your *home*  directory  for  such  a  big
installation but rather  to create and use some  other directory (here
``/opt/swtest``) that does not need to be backuped.

Preparation
---------------

Create specific  working and installation directories  and environment
variables:

.. code:: shell

   $ sudo mkdir -p /opt/swtest
   $ sudo chmod 1777 /opt/swtest
   $ mkdir -p /opt/swtest/BxSoftware
   $ export BX_CACHE_DIR="/opt/swtest/BxSoftware/BxCache"
   $ export BX_WORK_DIR="/opt/swtest/BxSoftware/BxWork"
   $ export BX_INSTALL_BASE_DIR="/opt/swtest/BxSoftware/BxInstall"
   $ export BX_CONFIG_DIR="/opt/swtest/BxSoftware/BxConfig"
   $ mkdir -p ${BX_CACHE_DIR}
   $ mkdir -p ${BX_WORK_DIR}
   $ mkdir -p ${BX_INSTALL_BASE_DIR}
   $ mkdir -p ${BX_CONFIG_DIR}
   $ tree /opt/swtest/BxSoftware
..

..
   CAMP installation
   -----------------

   .. code:: shell

      $ cd ./BxCampInstaller/
      $ ./camp_installer  --package-version "0.8.4"
      $ ls -l ${BX_CONFIG_DIR}/modules/camp@0.8.4.bash
   ..


CLHEP installation
---------------------

.. code:: shell

   $ cd ../BxClhepInstaller/
   $ ./clhep_installer --package-version "2.1.4.2"
   $ ls -l ${BX_CONFIG_DIR}/modules/clhep@2.1.4.2.bash
..

ROOT installation
---------------------

.. code:: shell

   $ cd ../BxRootInstaller/
   $ ./root_installer --package-version "6.16.00"
   $ ls -l ${BX_CONFIG_DIR}/modules/root@6.16.00.bash
..


Geant4 datasets installation
--------------------------------

.. code:: shell

   $ cd ../BxGeant4DatasetsInstaller
   $ ./g4datasets_installer --package-version "9.6.4"
   $ ls -l ${BX_CONFIG_DIR}/modules/g4datasets@9.6.4.bash
..

Geant4  installation
--------------------------------

#. Setup dependencies:

   .. code:: shell

      $ source ${BX_CONFIG_DIR}/modules/clhep@2.1.4.2.bash
      $ source ${BX_CONFIG_DIR}/modules/g4datasets@9.6.4.bash
      $ clhep_2_1_4_2_setup
      [info] clhep_2_1_4_2_setup: CLHEP version 2.1.4.2 is now setup !
      $ which clhep-config 
      /opt/swtest/BxSoftware/BxInstall/clhep-2.1.4.2/bin/clhep-config
      $ g4datasets_9_6_4_setup
      [info] g4datasets_9_6_4_setup: Geant4 datasets version 9.6.4 is now setup !
      $ echo $G4LEDATA
   ..

#. Installation:

   .. code:: shell

      $ cd ../BxGeant4Installer
      /opt/swtest/BxSoftware/BxInstall/g4datasets-9.6.4/share/Geant4Datasets-9.6.4/data/G4EMLOW7.7
      $ ./geant4_installer --package-version "9.6.4"
      $ ls -l ${BX_CONFIG_DIR}/modules/geant4@9.6.4.bash
   ..


BxDecay0  installation
--------------------------------

.. code:: shell
	  
   $ cd ../BxDecay0Installer
   $ ./bxdecay0_installer --package-version "1.1.0"
   $ ls -l ${BX_CONFIG_DIR}/modules/bxdecay0@1.1.0.bash
..
   

Bayeux  installation
--------------------------------

#. Setup additional  dependencies, assuming  CLHEP 2.1.4.2  and Geant4
   datasets 9.6.4 have been setup before:

   .. code:: shell

      $ source ${BX_CONFIG_DIR}/modules/root@6.16.00.bash
      $ root_6_16_00_setup 
      [info] root_6_16_00_setup: ROOT version 6.16.00 is now setup !
      $ root-config --prefix
      /opt/swtest/BxSoftware/BxInstall/root-6.16.00
      
      $ source ${BX_CONFIG_DIR}/modules/geant4@9.6.4.bash
      $ geant4_9_6_4_setup 
      [info] geant4_9_6_4_setup: GEANT4 version 9.6.4 is now setup !
      $ geant4-config --prefix
      /opt/swtest/BxSoftware/BxInstall/geant4-9.6.4/bin/..
 
      $ source ${BX_CONFIG_DIR}/modules/bxdecay0@1.1.0.bash
      $ bxdecay0_1_1_0_setup 
      [info] bxdecay0_1_1_0_setup: BxDecay0 version 1.1.0 is now setup !
      $ bxdecay0-config --prefix
      /opt/swtest/BxSoftware/BxInstall/bxdecay0-1.1.0
   ..

.. $ source ${BX_CONFIG_DIR}/modules/camp@0.8.4.bash
   $ camp_setup
   [info] camp_setup: CAMP version 0.8.4 is now setup !
   $ echo $BX_CAMP_INSTALL_DIR 
   /opt/swtest/BxSoftware/BxInstall/camp-0.8.4


   
#. Installation:

   .. code:: shell
	  
      $ cd ../BxBayeuxInstaller/
      $ ./bayeux_installer --package-version "3.5.2" --with-qt --with-geant4   
      $ ls -l ${BX_CONFIG_DIR}/modules/bayeux@3.5.0.bash
   ..

#. Setup:

   .. code:: shell

      $ source ${BX_CONFIG_DIR}/modules/bayeux@3.5.2.bash
      $ bayeux_3_5_2_setup 
      [info] bayeux_3_5_0_setup: Bayeux version 3.5.2 is now setup !
      $ bxquery --prefix
      /opt/swtest/BxSoftware/BxInstall/bayeux-3.5.2
   ..	  

 
Final setup
=================


   #. Create a bash script : ``/opt/swtest/BxSoftware/BxConfig/bxsoftware.bash``

      .. code:: shell

	 export BX_CACHE_DIR="/opt/swtest/BxSoftware/BxCache"
	 export BX_WORK_DIR="/opt/swtest/BxSoftware/BxWork"
	 export BX_INSTALL_BASE_DIR="/opt/swtest/BxSoftware/BxInstall"
	 export BX_CONFIG_DIR="/opt/swtest/BxSoftware/BxConfig"
      ..
      
   #. Create a bash script : ``/opt/swtest/BxSoftware/BxConfig/bayeux_run_setup.bash``

.. source ${BX_CONFIG_DIR}/modules/camp@0.8.4.bash

      .. code:: shell

	 source ${BX_CONFIG_DIR}/modules/root@6.16.00.bash
	 source ${BX_CONFIG_DIR}/modules/clhep@2.1.4.2.bash
	 source ${BX_CONFIG_DIR}/modules/g4datasets@9.6.4.bash
	 source ${BX_CONFIG_DIR}/modules/geant4@9.6.4.bash
 	 source ${BX_CONFIG_DIR}/modules/bxdecay0@1.1.0.bash
	 source ${BX_CONFIG_DIR}/modules/bayeux@3.5.2.bash

	 function bayeux_3_5_2_run_setup()
	 {
	   clhep_2_1_4_2_setup
	   root_6_16_00_setup 
	   g4datasets_9_6_4_setup       
	   geant4_9_6_4_setup
	   bxdecay0_1_1_0_setup  
	   bayeux_3_5_2_setup 
	   echo >&2 "[notice] Bayeux 3.5.2 is setup."
	 }
	 alias bayeux_run_setup='bayeux_3_5_2_run_setup'
      ..

     
   #. Add the following lines in your startup script : ``~/.bashrc``
    
      .. code:: shell

	 # Bayeux setup:
	 source /opt/swtest/BxSoftware/BxConfig/bxsoftware.bash
	 source /opt/swtest/BxSoftware/BxConfig/bayeux_run_setup.bash
      ..
      

   #. To use Bayeux from a shell, type:
      
      .. code:: shell
	  
	 $ bayeux_run_setup
	 [info] clhep_2_1_4_2_setup: CLHEP version 2.1.4.2 is now setup !
	 [info] root_6_16_00_setup: ROOT version 6.16.00 is now setup !
	 [info] g4datasets_9_6_4_setup: Geant4 datasets version 9.6.4 is now setup !
	 [info] geant4_9_6_4_setup: GEANT4 version 9.6.4 is now setup !
	 [info] bxdecay0_1_1_0_setup: BxDecay0 version 1.1.0 is now setup !
	 [info] bayeux_3_5_2_setup: Bayeux version 3.5.2 is now setup !
	 [notice] Bayeux 3.5.2 is setup.
	 $ bxquery --version
	 3.5.2
	 $ bxquery --prefix
	 /opt/swtest/BxSoftware/BxInstall/bayeux-3.5.2
      ..

      This will setup/activate Bayeux with all its dependencies.
   
   #. Any project that needs Bayeux to be built and run must use the above
      procedure.
      

Final remark
=================

In principle, after  all the software you need has  been installed and
setup,  you  can  remove  the  contents  of  the  *cache*  and  *work*
directories to  save storage space  on your system. I  found generally
useful  to preserve  the  *cache* directory  in order  to  be able  to
reprocess some installation off line.


.. end
   

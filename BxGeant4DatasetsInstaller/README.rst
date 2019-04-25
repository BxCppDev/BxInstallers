======================================
Geant4 Datasets Installer for Bayeux
======================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2019-03-31


This is the Geant4 Datasets Installer provided by the Bayeux
development group.
       

Requirements
============

None.

Usage
======

.. code:: bash
	  
   $ ./g4datasets_installer --help
..


Install Geant4 Datasets
=======================

User install
------------

.. code: shell

   $ g4datasets_installer 
..


System install (sudo)
---------------------

.. code: shell

   $ sudo g4datasets_installer --system-install 
..



Create a Debian package
=======================

.. code: shell

   $ ./mkdebpackage
..



Use the Debian package
=======================

.. code: shell

   $ dpkg -i bxg4datasets-installer_10.5_all.deb
..

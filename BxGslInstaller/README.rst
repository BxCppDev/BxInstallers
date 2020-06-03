=================================
GSL installation for Bayeux
=================================

:author: F.Mauger <mauger@lpccaen.in2p3.fr>
:date: 2020-06-03

GSL installer for Ubuntu provided by the Bayeux
development group.

Default GSL version: 2.4

Requirements
============

  
Usage
======

.. code:: bash
	  
   $ ./gsl_installer --help
..

Installation on Ubuntu 20.04
============================

Personal installation
---------------------

Installation as standard user
-----------------------------

   
Build and make a binary package
===============================

Generate a ``bxgsl_2.4-1_amd64.deb`` binary Debian package:

.. code:: bash
	  
   $ sudo ./gsl_installer.bash \
       --pkg-build \
       --pkg-maintener "john.doe@acme.net" 
..

Check the package:

.. code:: bash
	  
   $ dpkg -c bxgsl_2.4-1_amd64.deb
..

Then install the package:

.. code:: bash
	  
   $ sudo dpkg -i bxgsl_2.4-1_amd64.deb
..



.. end

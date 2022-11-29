#!/usr/bin/env bash
# Author: F.Mauger
# Date: 2022-11-29
# Description:
# A script which should build, install and setup Bayeux and its dependencies
# on Ubuntu 22.04.

do_bayeux=true
bx_base_dir=

while [ -n "$1" ]; do
    arg="$1"
    echo >&2 "[info] arg='${arg}'"
    if [ "${arg}" = "--base-dir" ]; then
	shift 1
	bx_base_dir="$1"
    elif [ "${arg}" = "--no-bayeux" ]; then
	do_bayeux=false
    fi
    shift 1
done

if [ -z "${bx_base_dir}" ]; then
    
    if [ -z "${BX_BASE_DIR}" ]; then
	bx_base_dir="${HOME}/BxSoftware"
	echo >&2 "[info] Setting the default base directory for BxInstaller software : '${HOME}/BxSoftware/'"
    else
	echo >&2 "[info] Setting the default base directory for BxInstaller software from env BX_BASE_DIR='${BX_BASE_DIR}'"
	bx_base_dir="${BX_BASE_DIR}"
    fi
fi

if [ ! -d "${bx_base_dir}" ]; then
   echo >&2 "[info] Creating the '${bx_base_dir}' base directory for BxInstaller software..."
   mkdir -p ${bx_base_dir}
   if [ $? -ne 0 ]; then
       echo >&2 "[error] Failed to create '${bx_base_dir}' base directory for BxInstaller software!"
      exit 1 
   fi
fi
echo >&2 "[info] bx_base_dir='${bx_base_dir}' is the base directory for BxInstaller software"
exit 1

export BX_CACHE_DIR="${bx_base_dir}/BxCache"
export BX_WORK_DIR="${bx_base_dir}/BxWork"
export BX_INSTALL_BASE_DIR="${bx_base_dir}/BxInstall"
export BX_PACKAGE_DIR="${bx_base_dir}/BxPackage"
export BX_CONFIG_DIR="${bx_base_dir}/BxConfig"

test -d ${BX_CACHE_DIR}        || mkdir -p ${BX_CACHE_DIR}
test -d ${BX_WORK_DIR}         || mkdir -p ${BX_WORK_DIR}
test -d ${BX_INSTALL_BASE_DIR} || mkdir -p ${BX_INSTALL_BASE_DIR}
test -d ${BX_PACKAGE_DIR}      || mkdir -p ${BX_PACKAGE_DIR}
test -d ${BX_CONFIG_DIR}       || mkdir -p ${BX_CONFIG_DIR}

if [ ! -f ${BX_WORK_DIR}/clhep-2.1.4.2/tag.d/installed.tag ]; then
    echo >&2 "[info] installing CLHEP..."
    cd BxClhepInstaller
    ./clhep_installer \
	--package-version "2.1.4.2"
    cd ..
fi
if [ -f ${BX_CONFIG_DIR}/modules/clhep@2.1.4.2.bash ]; then
    echo >&2 "[info] setup CLHEP..."
    source ${BX_CONFIG_DIR}/modules/clhep@2.1.4.2.bash
    clhep_2_1_4_2_setup
fi

if [ ! -f ${BX_WORK_DIR}/root-6.26.06/tag.d/installed.tag ]; then
    echo >&2 "[info] installing ROOT..."
    cd BxRootInstaller
    ./root_installer \
	--package-version "6.26.06" \
	--cxx14 \
	--with-python \
	--with-xrootd --without-buildin-xrootd
    cd ..
fi
if [ -f ${BX_CONFIG_DIR}/modules/root@6.26.06.bash ]; then
    echo >&2 "[info] setup ROOT..."
    source ${BX_CONFIG_DIR}/modules/root@6.26.06.bash
    root_6_26_06_setup
fi

if [ ! -f ${BX_WORK_DIR}/g4datasets-9.6.4/tag.d/installed.tag ]; then
    echo >&2 "[info] installing G4 datasets..."
    cd BxGeant4DatasetsInstaller/
    ./g4datasets_installer \
	--package-version "9.6.4" \
    cd ..
fi
if [ -f ${BX_CONFIG_DIR}/modules/g4datasets@9.6.4.bash ]; then
    echo >&2 "[info] setup G4 datasets..."
    source ${BX_CONFIG_DIR}/modules/g4datasets@9.6.4.bash
    g4datasets_9_6_4_setup
fi

if [ ! -f ${BX_WORK_DIR}/geant4-9.6.4/tag.d/installed.tag ]; then
    echo >&2 "[info] installing Geant4..."
    cd BxGeant4Installer/
    ./geant4_installer \
	--package-version "9.6.4" \
    cd ..
fi
if [ -f ${BX_CONFIG_DIR}/modules/geant4@9.6.4.bash ]; then
    echo >&2 "[info] setup Geant4..."
    source ${BX_CONFIG_DIR}/modules/geant4@9.6.4.bash
    geant4_9_6_4_setup
fi

if [ ! -f ${BX_WORK_DIR}/bxdecay0-1.1.0/tag.d/installed.tag ]; then
    cd BxDecay0Installer/
    ./bxdecay0_installer \
	--package-version "1.1.0" \
    cd ..
fi
if [ -f ${BX_CONFIG_DIR}/modules/bxdecay0@1.1.0.bash ]; then
    source ${BX_CONFIG_DIR}/modules/bxdecay0@1.1.0.bash
    bxdecay0_1_1_0_setup
fi

if [ ${do_bayeux} = true ]; then
    if [ ! -f ${BX_WORK_DIR}/bayeux-3.5.3/tag.d/installed.tag ]; then
	cd BxBayeuxInstaller/
	./bayeux_installer \
	    --package-version "3.5.3" \
	    --cxx-14 \
	    --with-qt \
	    --with-tests \
	    --with-docs \
	    --with-geant4
	cd ..
    fi
    if [ -f ${BX_CONFIG_DIR}/modules/bayeux@3.5.3.bash ]; then
	source ${BX_CONFIG_DIR}/modules/bayeux@3.5.3.bash
	bayeux_3_5_3_setup
    fi
fi

# exit 0

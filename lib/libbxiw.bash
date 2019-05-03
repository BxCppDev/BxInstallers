# -*- mode: shell-script; -*-

### if [ "x${__libbxiw_loaded}" = "x" ]; then

if [ "x${bxiw_app_name}" = "x" ]; then
    bxiw_app_name=
fi
if [ "x${bxiw_app_saved_pwd}" = "x" ]; then
    bxiw_app_saved_pwd=
fi
if [ "x${bxiw_app_installer_prefix}" = "x" ]; then
    bxiw_app_installer_prefix=
fi
bxiw_app_cl_remaining_argv="$@"
bxiw_mute=false
bxiw_trace=false
bxiw_with_gui=false
if [ "x${bxiw_default_package_version}" = "x" ]; then
    bxiw_default_package_version=
fi
if [ "x${bxiw_package_name}" = "x" ]; then
    bxiw_package_name=
fi
if [ "x${bxiw_package_version}" = "x" ]; then
    bxiw_package_version=
fi

bxiw_os_name=$(uname -s)
bxiw_os_arch=$(uname -m)
bxiw_os_distrib_id=
bxiw_os_distrib_release=
bxiw_nbprocs=$(cat /proc/cpuinfo | grep ^processor | wc -l)
bxiw_default_cache_directory="${HOME}/bxsoftware/_cache.d"
bxiw_default_working_directory="${HOME}/bxsoftware/_work.d"
bxiw_default_install_base_dir="${HOME}/bxsoftware/install"
bxiw_default_package_dir="${HOME}/bxsoftware/_package.d"
bxiw_setup_dir="${HOME}/.bxsoftware.d"
if [ ${UID} -eq 0 ]; then
    bxiw_default_cache_directory="/var/bxsoftware/cache.d"    
    bxiw_default_working_directory="/var/bxsoftware/work.d"    
    bxiw_default_install_base_dir="/opt/bxsoftware/install"    
    bxiw_default_package_dir="/var/bxsoftware/package.d"
    bxiw_setup_dir="/etc/bxsoftware"
fi
if [ "x${bxiw_setup_module_dir}" = "x" ]; then
    bxiw_setup_module_dir=
fi
bxiw_default_timeout_seconds=3600
bxiw_timeout_seconds=0
bxiw_install_base_dir=
if [ "x${bxiw_system_install}" = "x" ]; then
    bxiw_system_install=false
fi
if [ "x${bxiw_default_pkg_maintener_email}" = "x" ]; then
    bxiw_default_pkg_maintener_email="bayeux@lpccaen.in2p3.fr"
fi
if [ "x${bxiw_pkg_maintener_email}" = "x" ]; then
    bxiw_pkg_maintener_email=
fi
if [ "x${bxiw_default_pkg_release}" = "x" ]; then
    bxiw_default_pkg_release=1
fi
if [ "x${bxiw_pkg_release}" = "x" ]; then
    bxiw_pkg_release=0
fi
__bxiw_disable_package=false
bxiw_system_packages_build=
bxiw_system_packages_run=
bxiw_work_dir=
bxiw_cache_dir=
bxiw_package_dir=
bxiw_build_dir=
bxiw_tag_dir=
bxiw_install_dir=
bxiw_do_reconfigure=false
bxiw_do_rebuild=false
bxiw_do_reinstall=false
bxiw_no_build=false
bxiw_no_install=false
bxiw_with_package=false
bxiw_remove_build_dir=false
bxiw_remove_tarballs=false
bxiw_builder=
bxiw_builder_executable=
bxiw_delete_tags=false
bxiw_tag_downloaded=
bxiw_tag_source=
bxiw_tag_configured=
bxiw_tag_built=
bxiw_tag_installed=

function bxiw_pass()
{
    return 0
}

function bxiw_message()
{
    local _tag="$1"
    shift 1
    local _msg_txt="$@"
    if [ -n "${bxiw_app_name}" ]; then
	echo -n >&2 "${bxiw_app_name} "
    fi
    echo >&2 "[${_tag}] ${_msg_txt}"
    return 0
}


function bxiw_log_trace()
{
    if [ ${bxiw_trace} == true ]; then
	bxiw_message "trace" $@
    fi
    return 0
}


function bxiw_log_trace_entering()
{
    bxiw_log_trace "$1: entering..."
    return 0
}


function bxiw_log_trace_exiting()
{
    bxiw_log_trace "$1: exiting."
    return 0
}


function bxiw_log_info()
{
    if [ ${bxiw_mute} == false ]; then
	bxiw_message "info" $@
    fi
    return 0
}


function bxiw_log_error()
{
    bxiw_message "error" $@
    return 0
}


function bxiw_exit()
{
    local error_code=$1
    shift 1
    local error_message="$@"
    if [ "x${error_message}" != "x" -a ${error_code} -ne 0 ]; then
	bxiw_log_error "${error_message}" 
    fi
    if [ -n "${bxiw_app_saved_pwd}" ]; then
	cd ${bxiw_app_saved_pwd}
    fi
    exit ${error_code} 
}


function bxiw_detect_os()
{
    if [ "x${bxiw_os_name}" = "xLinux" ]; then
	if [ -f /etc/lsb-release ]; then
	    bxiw_os_distrib_id=$(grep ^DISTRIB_ID= /etc/lsb-release | cut -d= -f2)
	    bxiw_os_distrib_release=$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)
	elif [ -f /etc/redhat-release ]; then
	    bxiw_os_distrib_id=$(cat /etc/redhat-release | cut -d' ' -f1)
	    bxiw_os_distrib_release=$(cat /etc/redhat-release | cut -d' ' -f4 | cut -d. -f1,2)
	fi
    else
	return 1
    fi
    return 0
}


function bxiw_env()
{
    if [ "x${BX_CACHE_DIR}" != "x" ]; then
	bxiw_cache_dir="${BX_CACHE_DIR}"
	bxiw_log_info "Cache directory is set from the BX_CACHE_DIR environment variable: '${bxiw_cache_dir}'"
    fi
    
    if [ "x${BX_WORK_DIR}" != "x" ]; then
	bxiw_work_dir="${BX_WORK_DIR}"
	bxiw_log_info "Work directory is set from the BX_WORK_DIR environment variable: '${bxiw_work_dir}'"
    fi
    
    if [ "x${BX_INSTALL_BASE_DIR}" != "x" ]; then
	bxiw_install_base_dir="${BX_INSTALL_BASE_DIR}"
	bxiw_log_info "Installation base directory is set from the BX_INSTALL_BASE_DIR environment variable: '${bxiw_install_base_dir}'"
    fi
   
    if [ "x${BX_PACKAGE_DIR}" != "x" ]; then
	bxiw_package_dir="${BX_PACKAGE_DIR}"
	bxiw_log_info "Package directory is set from the BX_PACKAGE_DIR environment variable: '${bxiw_package_dir}'"
    fi

    return 0
}


function bxiw_check_installed_system_package()
{
    local _syspackage_name="$1"
    shift 1
    bxiw_log_info "Checking package '${_syspackage_name}'..."
    if [ "x${_syspackage_name}" = "x" ]; then
	bxiw_exit 1 "Missing system package name!"
    fi
    if [ "x${bxiw_os_distrib_id}" = "xUbuntu" ]; then
	### dpkg-query -l ${_syspackage_name}
	dpkg-query -s ${_syspackage_name} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
	    return 1
	fi
    elif [ "x${bxiw_os_distrib_id}" = "xCentOS" ]; then
	sudo yum list installed ${_syspackage_name}
	if [ $? -ne 0 ]; then
	    return 1
	fi
    elif [ "x${bxiw_os_distrib_id}" = "xScientific" ]; then
	sudo yum list installed ${_syspackage_name}
	if [ $? -ne 0 ]; then
	    return 1
	fi
    else
	bxiw_log_error "Unsupported OS distribution '${bxiw_os_distrib_id}'"
	return 1
    fi
    return 0
}


function bxiw_install_system_package()
{
    local _error_code=0
    local _syspackage_name="$1"
    shift 1
    if [ "x${_syspackage_name}" = "x" ]; then
	bxiw_exit 1 "Missing system package name!"
    fi
    bxiw_check_installed_system_package ${_syspackage_name}
    if [ $? -eq 0 ]; then
	bxiw_log_info "System package '${_syspackage_name}' is already installed!"
    else
	bxiw_log_info "Installing system package '${_syspackage_name}'..."
	if [ "x${os_distrib_id}" = "xUbuntu" ]; then
	    sudo apt-get install ${_syspackage_name}
	    _error_code=$?
	elif [ "x${os_distrib_id}" = "xCentOS" ]; then
	    sudo yum install ${_syspackage_name}
	    _error_code=$?
	elif [ "x${os_distrib_id}" = "xScientific" ]; then
	    sudo yum install ${_syspackage_name}
	    _error_code=$?
	fi
    fi
    if [ ${_error_code} -ne 0 ]; then
	bxiw_log_error "Could not install system package '${_syspackage_name}'!"
    fi
    return ${_error_code}
}


function bxiw_install_system_dependencies()
{
    for _syspackage in ${bxiw_system_packages_build}; do
	bxiw_install_system_package ${_syspackage}
	if [ $? -ne 0 ]; then
	    return 1
	fi
    done
    return 0
}


function _bxiw_usage_options()
{
    cat<<EOF
  --package-version version  
                       Set the version of the software
  --gui                Activate GUI
  --work-dir path      Set the working directory (build/tag)
  --cache-dir path     Set the cache directory 
  --install-dir path   Set the installation directory
  --delete-tags	       Delete all existing tag files
  --reconfigure	       Force reconfigure      
  --no-build           Configuration only      
  --rebuild	       Force rebuild      
  --reinstall	       Force reinstallation      
  --no-install         Build only
  --system-install     Perform a system installation
  --timeout duration   Set the timeout duration for downloading files (in seconds)
EOF
    if [ ${__bxiw_disable_package} == false ]; then
	cat<<EOF
  --no-pkg-build       Do not build the package
  --pkg-build          Build the package (default=no, implies --system-install)
  --pkg-maintener      Set the package maintener email address
  --pkg-release        Set the package release number
EOF
    fi
    return 0
}


function bxiw_parse_cl()
{
    local _remaining=
    while [ -n "$1" ]; do
	token="$1"
	if [ "x${token:0:1}" = "x-" ]; then
	    opt="${token}"
	    if [ ${opt} = "--trace" ]; then
		bxiw_trace=true
	    elif [ ${opt} = "--package-version" ]; then
		shift 1
		bxiw_package_version="$1"
	    elif [ ${opt} = "--cache-dir" ]; then
		shift 1
		bxiw_cache_dir="$1"
	    elif [ ${opt} = "--work-dir" ]; then
		shift 1
		bxiw_work_dir="$1"
	    elif [ ${opt} = "--install-dir" ]; then
		shift 1
		bxiw_install_dir="$1"
	    elif [ ${opt} = "--package-dir" ]; then
		shift 1
		bxiw_package_dir="$1"
	    elif [ ${opt} = "--delete-tags" ]; then
		bxiw_delete_tags=true
	    elif [ ${opt} = "--reconfigure" ]; then
		bxiw_do_reconfigure=true
	    elif [ ${opt} = "--rebuild" ]; then
		bxiw_do_rebuild=true
	    elif [ ${opt} = "--reinstall" ]; then
		bxiw_do_reinstall=true
	    elif [ ${opt} = "--no-build" ]; then
		bxiw_no_build=true
	    elif [ ${opt} = "--no-install" ]; then
		bxiw_no_install=true
	    elif [ ${opt} = "--remove-build-dir" ]; then
		bxiw_remove_build_dir=true
	    elif [ ${opt} = "--preserve-build-dir" ]; then
		bxiw_remove_build_dir=false
	    elif [ ${opt} = "--remove-tarballs" ]; then
		bxiw_remove_tarballs=true
	    elif [ ${opt} = "--gui" ]; then
		bxiw_with_gui=true	
	    elif [ ${opt} = "--system-install" ]; then
		bxiw_system_install=true
	    elif [ ${opt} = "--timeout" ]; then
		shift 1
		bxiw_timeout_seconds=$1
	    elif [ ${__bxiw_disable_package} == false -a ${opt} = "--no-pkg-build" ]; then
		bxiw_with_package=false
	    elif [ ${__bxiw_disable_package} == false -a ${opt} = "--pkg-build" ]; then
		bxiw_with_package=true
	    elif [ ${__bxiw_disable_package} == false -a ${opt} = "--pkg-maintener" ]; then
		shift 1
		bxiw_pkg_maintener_email="$1"
		bxiw_with_package=true
	    elif [ ${__bxiw_disable_package} == false -a ${opt} = "--pkg-release" ]; then
		shift 1
		bxiw_pkg_release="$1"
	    else
		_remaining="${_remaining} $1"
	    fi
	else
	    _remaining="${_remaining} $1"
 	fi
	shift 1
    done
    bxiw_app_cl_remaining_argv=${_remaining}
    return 0
}


function _bxiw_prepare_post()
{
    if [ "x${bxiw_builder}" = "xmake" ]; then
	bxiw_builder_executable="make"
    elif [ "x${bxiw_builder}" = "xninja" ]; then
	bxiw_builder_executable="ninja"
    fi

    if [ "x${bxiw_build_dir}" = "x" ]; then
	bxiw_build_dir="${bxiw_work_dir}/${bxiw_package_name}-${bxiw_package_version}/build.d"
    fi

    if [ "x${bxiw_tag_dir}" = "x" ]; then
	bxiw_tag_dir="${bxiw_work_dir}/${bxiw_package_name}-${bxiw_package_version}/tag.d"
    fi

    bxiw_tag_downloaded="${bxiw_tag_dir}/downloaded.tag"
    bxiw_tag_source="${bxiw_tag_dir}/source.tag"
    bxiw_tag_configured="${bxiw_tag_dir}/configured.tag"
    bxiw_tag_built="${bxiw_tag_dir}/built.tag"
    bxiw_tag_installed="${bxiw_tag_dir}/installed.tag"

    if [ ${bxiw_delete_tags} == true ]; then
	bxiw_log_info "Deleting existing tag files..."
	rm -f ${bxiw_tag_dir}/*.tag
    fi
    
    if [ ! -d ${bxiw_cache_dir} ]; then
	mkdir -p ${bxiw_cache_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Cannot create the '${bxiw_cache_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "Cache directory '${bxiw_cache_dir}' is created!"
	fi
    else
	bxiw_log_info "Cache directory '${bxiw_cache_dir}' already exists!"
    fi
     
    if [ ${bxiw_do_rebuild} == true -a -d ${bxiw_build_dir} ]; then
	bxiw_log_info "Removing existing '${bxiw_build_dir}' build directory..."
	rm -fr ${bxiw_build_dir}
    fi
        
    if [ ! -d ${bxiw_build_dir} ]; then
	mkdir -p ${bxiw_build_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Cannot create the '${bxiw_build_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "Build directory '${bxiw_build_dir}' is created!"
	fi
    fi
         
    if [ ! -d ${bxiw_tag_dir} ]; then
	mkdir -p ${bxiw_tag_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Cannot create the '${bxiw_tag_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "Build directory '${bxiw_tag_dir}' is created!"
	fi
    fi
    
    if [ ${bxiw_with_package} == true ]; then
	bxiw_system_install=true
	if [ ! -d ${bxiw_package_dir} ]; then
	    mkdir -p ${bxiw_package_dir}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "Cannot create the '${bxiw_package_dir}' directory!"
		return 1
	    else
		bxiw_log_info "Package directory '${bxiw_package_dir}' is created!"
	    fi
	fi
    fi
         
    if [ ${bxiw_system_install} == true ]; then
	bxiw_install_dir="/usr"
    else     
	if [ ! -d ${bxiw_install_base_dir} ]; then
	    mkdir -p ${bxiw_install_base_dir}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "Cannot create the '${bxiw_install_base_dir}' directory!"
		return 1
	    else
		bxiw_log_info "Installation base directory '${bxiw_install_base_dir}' was created!"
	    fi
	fi
	local _default_install_directory="${bxiw_install_base_dir}/${bxiw_package_name}-${bxiw_package_version}"
	if [ "x${bxiw_install_dir}" = "x" ]; then
	    bxiw_install_dir="${_default_install_directory}"
	fi
    fi
    
    if [ ! -d ${bxiw_setup_module_dir} ]; then
	mkdir -p ${bxiw_setup_module_dir}
	if [ $? -ne 0 ]; then
    	    bxiw_log_error "Creation of directory '${bxiw_setup_module_dir}' failed!"
	    return 1
	else
	    bxiw_log_info "Setup directory '${bxiw_setup_module_dir}' is created!"
	fi
    fi
 
    return 0
}


function _bxiw_prepare_pre()
{
    bxiw_uid=${UID}

    if [ ${bxiw_system_install} = true -a ${bxiw_uid} -ne 0 ]; then
	bxiw_exit 1 "Invalid priviledge for a system installation!"
    fi
    
    if [ "x${bxiw_builder}" = "x" ]; then
	bxiw_builder="make"
    fi
    
    if [ "x${bxiw_package_version}" = "x" ]; then
	bxiw_package_version="${bxiw_default_package_version}"
    fi

    if [ "x${bxiw_cache_dir}" = "x" ]; then
	bxiw_cache_dir="${bxiw_default_cache_directory}"
    fi

    if [ ${bxiw_timeout_seconds} -eq 0 ]; then
	bxiw_timeout_seconds=${bxiw_default_timeout_seconds}
    fi

    if [ "x${bxiw_work_dir}" = "x" ]; then
	bxiw_work_dir="${bxiw_default_working_directory}"
    fi

    if [ "x${bxiw_install_base_dir}" = "x" ]; then
	bxiw_install_base_dir="${bxiw_default_install_base_dir}"
    fi

    if [ "x${bxiw_package_dir}" = "x" ]; then
	bxiw_package_dir="${bxiw_default_package_directory}"
    fi

    if [ "x${bxiw_setup_module_dir}" = "x" ]; then
	bxiw_setup_module_dir="${bxiw_setup_dir}/modules"
    fi
 
    if [ "x${bxiw_pkg_maintener_email}" = "x" ]; then
	bxiw_pkg_maintener_email="${bxiw_default_pkg_maintener_email}"
    fi

    if [ ${bxiw_pkg_release} -eq 0 ]; then
	bxiw_pkg_release=${bxiw_default_pkg_release}
    fi
     
    return 0
}


function bxiw_print()
{
    bxiw_log_info "bxiw_app_name            = '${bxiw_app_name}'"
    bxiw_log_info "bxiw_package_name        = '${bxiw_package_name}'"
    bxiw_log_info "bxiw_package_version     = '${bxiw_package_version}'"
    bxiw_log_info "bxiw_os_name             = '${bxiw_os_name}'"
    bxiw_log_info "bxiw_os_arch             = '${bxiw_os_arch}'"
    bxiw_log_info "bxiw_os_distrib_id       = '${bxiw_os_distrib_id}'"
    bxiw_log_info "bxiw_os_distrib_release  = '${bxiw_os_distrib_release}'"
    bxiw_log_info "bxiw_system_packages_build : "
    for _syspackname in ${bxiw_system_packages_build}; do
	bxiw_log_info "  - ${_syspackname}"
    done
    bxiw_log_info "bxiw_system_packages_run : "
    for _syspackname in ${bxiw_system_packages_run}; do
	bxiw_log_info "  - ${_syspackname}"
    done
    bxiw_log_info "bxiw_nbprocs             = ${bxiw_nbprocs}"
    bxiw_log_info "bxiw_uid                 = ${bxiw_uid}"
    bxiw_log_info "bxiw_timeout_seconds     = ${bxiw_timeout_seconds}"
    bxiw_log_info "bxiw_system_install      = ${bxiw_system_install}"
    bxiw_log_info "bxiw_install_base_dir    = '${bxiw_install_base_dir}'"
    bxiw_log_info "bxiw_work_dir            = '${bxiw_work_dir}'"
    bxiw_log_info "bxiw_cache_dir           = '${bxiw_cache_dir}'"
    bxiw_log_info "bxiw_package_dir         = '${bxiw_package_dir}'"
    bxiw_log_info "bxiw_build_dir           = '${bxiw_build_dir}'"
    bxiw_log_info "bxiw_install_dir         = '${bxiw_install_dir}'"
    bxiw_log_info "bxiw_do_reconfigure      = ${bxiw_do_reconfigure}"
    bxiw_log_info "bxiw_no_build            = ${bxiw_no_build}"
    bxiw_log_info "bxiw_do_rebuild          = ${bxiw_do_rebuild}"
    bxiw_log_info "bxiw_remove_build_dir    = ${bxiw_remove_build_dir}"
    bxiw_log_info "bxiw_remove_tarballs     = ${bxiw_remove_tarballs}"
    bxiw_log_info "bxiw_no_install          = ${bxiw_no_install}"
    bxiw_log_info "bxiw_with_package        = ${bxiw_with_package}"
    bxiw_log_info "bxiw_pkg_maintener_email = '${bxiw_pkg_maintener_email}'"
    bxiw_log_info "bxiw_pkg_release         = '${bxiw_pkg_release}'"
    return 0
}


function bxiw_download_file()
{
    local _opwd=$(pwd)
    local _url="$1"
    shift 1
    local _file="$1"
    shift 1 
    bxiw_log_trace "URL : '${_url}'"
    bxiw_log_trace "File to be dowloaded : '${_file}'"
    if  [ "x${_file}" = "x" ]; then
	_file="$(echo ${_url} | tr '/' '\n' | tail -1)"
    fi
    if [ ! -f ${bxiw_cache_dir}/${_file} ]; then
	cd ${bxiw_cache_dir}
	bxiw_log_info "Downloading tarball '${_file}' from '${_url}'..."
	if [ "${_url:0:5}" = "file:" ]; then
	    cp -f "${_url}" "${bxiw_cache_dir}/${_file}"
	else
	    wget ${_url} -O "${bxiw_cache_dir}/${_file}"
	    if [ $? -ne 0 ]; then
		bxiw_log_error "Cannot download the '${_file}' file!"
		cd ${_opwd}
		return 1
	    fi
	fi
    else
	bxiw_log_info "File '${_file}' already exists in '${bxiw_cache_dir}'!"
    fi
    cd ${_opwd}
    return 0
}


### export __libbxiw_loaded=1
### fi # __libbxiw_loaded

# end

# -*- mode: shell-script; -*-

### if [ "x${__libbxiw_loaded}" = "x" ]; then

# Default package traits:
__bxiw_enable_source_from_git=false
__bxiw_disable_package=true
__bxiw_enable_packaging=false
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
if [ "x${bxiw_supported_package_versions}" = "x" ]; then
    bxiw_supported_package_versions=
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
### bxiw_default_setup_dir="${HOME}/.bxsoftware.d"
bxiw_default_setup_dir="${HOME}/bxsoftware/config"
if [ "x${BX_CONFIG_DIR}" != "x" ]; then
    bxiw_setup_dir="${BX_CONFIG_DIR}"
else
    bxiw_setup_dir="${bxiw_default_setup_dir}"
fi
if [ ${UID} -eq 0 ]; then
    bxiw_default_cache_directory="/var/bxsoftware/cache.d"
    bxiw_default_working_directory="/var/bxsoftware/work.d"
    bxiw_default_install_base_dir="/opt/bxsoftware/install"
    bxiw_default_package_dir="/var/bxsoftware/config"
    bxiw_setup_dir="/etc/bxsoftware"
fi
if [ "x${bxiw_setup_module_dir}" = "x" ]; then
    bxiw_setup_module_dir=
fi
bxiw_setup_external_dir=
bxiw_default_timeout_seconds=3600
bxiw_source_from_git=false
# Next one seems not used !
bxiw_source_dir=
bxiw_source_git_path=
bxiw_source_git_branch=
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
bxiw_system_packages_build=
bxiw_system_packages_run=
bxiw_work_dir=
bxiw_cache_dir=
bxiw_cache_git_dir=
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
bxiw_archive_download_url=
bxiw_clean=false
# Examples:
# bxiw_archive_download_url="https://ftp.gnu.org/gnu/gsl/"

bxiw_downloaded_files=""


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


function bxiw_log_warning()
{
    bxiw_message "warning" $@
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
	if [ -f /etc/os-release ]; then
	    bxiw_os_distrib_id=$(grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d '"')
	    bxiw_os_distrib_release=$(grep ^VERSION_ID= /etc/os-release | cut -d= -f2 | tr -d '"')	    
	elif [ -f /etc/lsb-release ]; then
	    bxiw_os_distrib_id=$(grep ^DISTRIB_ID= /etc/lsb-release | cut -d= -f2)
	    bxiw_os_distrib_release=$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)
	else
	    return 1
	# elif [ -f /etc/redhat-release ]; then
	#     bxiw_os_distrib_id=$(cat /etc/redhat-release | cut -d' ' -f1)
	#     bxiw_os_distrib_release=$(cat /etc/redhat-release | cut -d' ' -f4 | cut -d. -f1,2)
	fi
    else
	return 1
    fi
    return 0
}


function bxiw_underscored_version()
{
    local _ver="$1"
    local _uver=$(echo ${_ver} | tr '.' '_' | tr '-' '_' | sed -e 's/-v/_/g' -e 's/-p/_/g')
    echo ${_uver}
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

    if [ "x${BX_CONFIG_DIR}" != "x" ]; then
	bxiw_setup_dir="${BX_CONFIG_DIR}"
	bxiw_log_info "Setup directory is set from the BX_CONFIG_DIR environment variable: '${bxiw_setup_dir}'"
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
    if [[ "x${bxiw_os_distrib_id}" = "xUbuntu" || "x${bxiw_os_distrib_id}" = "xLinuxMint" ]]; then
	### dpkg-query -l ${_syspackage_name}
	dpkg-query -s ${_syspackage_name} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Package '${_syspackage_name}' is not installed"
	    return 1
	fi
    elif [ "x${bxiw_os_distrib_id}" = "xCentOS" ]; then
	sudo yum list installed ${_syspackage_name}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Package '${_syspackage_name}' is not installed"
	    return 1
	fi
    elif [ "x${bxiw_os_distrib_id}" = "xScientific" ]; then
	sudo yum list installed ${_syspackage_name}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Package '${_syspackage_name}' is not installed"
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
	bxiw_log_info "System package '${_syspackage_name}' is already installed"
    else
	bxiw_log_info "Installing system package '${_syspackage_name}'..."
	if [[ "x${bxiw_os_distrib_id}" = "xUbuntu" || "x${bxiw_os_distrib_id}" = "xLinuxMint" ]]; then
	    sudo apt-get install ${_syspackage_name}
	    _error_code=$?
	elif [ "x${bxiw_os_distrib_id}" = "xCentOS" ]; then
	    sudo yum install ${_syspackage_name}
	    _error_code=$?
	elif [ "x${bxiw_os_distrib_id}" = "xScientific" ]; then
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
    local _do_it=false
    if [ ${UID} -eq 0 ]; then
	_do_it=true
    fi
    LANG=C id | tr ' ' '\n' | grep ^groups= | cut -d= -f2 | tr ',' '\n' | grep "(sudo)" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
	_do_it=true
    fi
    if [ ${_do_it} == true ]; then
	for _syspackage in ${bxiw_system_packages_build}; do
	    bxiw_install_system_package ${_syspackage}
	    if [ $? -ne 0 ]; then
		return 1
	    fi
	done
    fi
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
  --nprocs value       Set the maximum number of processors to be used at compile time (autodetected)
                       NB: A specific build process may decide to use only a fraction of the
                           available processors.
EOF

    if [ ${__bxiw_enable_source_from_git} == true ]; then
	cat<<EOF
  --source-from-git    Built from the Git development branch
  --source-git-path path
                       Set the Git repository path of the source
  --source-git-branch name
                       Set the Git branch to use as source repository
EOF

    fi

    if [ ${__bxiw_enable_packaging} == true ]; then
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
	    elif [ ${__bxiw_enable_source_from_git} == true -a ${opt} = "--source-from-git" ]; then
		bxiw_source_from_git=true
	    elif [ ${__bxiw_enable_source_from_git} == true -a ${opt} = "--source-git-path" ]; then
		shift 1
		bxiw_source_git_path="$1"
	    elif [ ${__bxiw_enable_source_from_git} == true -a ${opt} = "--source-git-branch" ]; then
		shift 1
		bxiw_source_git_branch="$1"
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
	    elif [ ${opt} = "--clean" ]; then
		bxiw_clean=true
	    elif [ ${opt} = "--gui" ]; then
		bxiw_with_gui=true
	    elif [ ${opt} = "--system-install" ]; then
		bxiw_system_install=true
	    elif [ ${opt} = "--timeout" ]; then
		shift 1
		bxiw_timeout_seconds=$1
	    elif [ ${opt} = "--nprocs" ]; then
		shift 1
		bxiw_nbprocs=$1
	    elif [ ${__bxiw_enable_packaging} == true -a ${opt} = "--no-pkg-build" ]; then
		bxiw_with_package=false
	    elif [ ${__bxiw_enable_packaging} == true -a ${opt} = "--pkg-build" ]; then
		bxiw_with_package=true
	    elif [ $__bxiw_enable_packaging} == true -a ${opt} = "--pkg-maintener" ]; then
		shift 1
		bxiw_pkg_maintener_email="$1"
		bxiw_with_package=true
	    elif [ ${__bxiw_enable_packaging} == true -a ${opt} = "--pkg-release" ]; then
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
    if [ ${bxiw_clean} == true ]; then
	bxiw_remove_build_dir=true
	bxiw_remove_tarballs=true
	bxiw_delete_tags=true
    fi
    return 0
}

function bxiw_make_absolute_dir_path()
{
    local __oldPwd=$(pwd)
    local __aPath="$1"
    if [ ! -d ${__aPath} ]; then
	mkdir -p ${__aPath}
    fi
    cd ${__aPath}
    local __absPath=$(pwd)
    cd ${__oldPwd}
    echo "${__absPath}"
    return
}

function _bxiw_prepare_post()
{
    if [ "x${bxiw_builder}" = "xmake" ]; then
	bxiw_builder_executable="make"
    elif [ "x${bxiw_builder}" = "xninja" ]; then
	bxiw_builder_executable="ninja"
    fi

    bxiw_log_info "_bxiw_prepare_post: Making absolute directories..."
    if [ -n "${bxiw_cache_dir}" ]; then
	bxiw_cache_dir=$(bxiw_make_absolute_dir_path ${bxiw_cache_dir})
    fi
    if [ -n "${bxiw_work_dir}" ]; then
	bxiw_work_dir=$(bxiw_make_absolute_dir_path ${bxiw_work_dir})
    fi
    if [ -n "${bxiw_build_dir}" ]; then
	bxiw_build_dir=$(bxiw_make_absolute_dir_path ${bxiw_build_dir})
    fi
    if [ -n "${bxiw_tag_dir}" ]; then
	bxiw_tag_dir=$(bxiw_make_absolute_dir_path ${bxiw_tag_dir})
    fi
    if [ -n "${bxiw_install_base_dir}" ]; then
	bxiw_install_base_dir=$(bxiw_make_absolute_dir_path ${bxiw_install_base_dir})
    fi
    if [ -n "${bxiw_install_dir}" ]; then
	bxiw_install_dir=$(bxiw_make_absolute_dir_path ${bxiw_install_dir})
    fi
    if [ -n "${bxiw_setup_module_dir}" ]; then
	bxiw_setup_module_dir=$(bxiw_make_absolute_dir_path ${bxiw_setup_module_dir})
    fi
    if [ -n "${bxiw_setup_external_dir}" ]; then
	bxiw_setup_external_dir=$(bxiw_make_absolute_dir_path ${bxiw_setup_external_dir})
    fi

    # Default build dir:
    if [ "x${bxiw_build_dir}" = "x" ]; then
	bxiw_build_dir="${bxiw_work_dir}/${bxiw_package_name}-${bxiw_package_version}/build.d"
    fi

    # Default tag dir:
    if [ "x${bxiw_tag_dir}" = "x" ]; then
	bxiw_tag_dir="${bxiw_work_dir}/${bxiw_package_name}-${bxiw_package_version}/tag.d"
    fi

    bxiw_log_info "_bxiw_prepare_post: Cache directory='${bxiw_cache_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Work directory='${bxiw_work_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Build directory='${bxiw_build_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Tag directory='${bxiw_tag_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Install base directory='${bxiw_install_base_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Install directory='${bxiw_install_dir}'"
    bxiw_log_info "_bxiw_prepare_post: Setup module directory='${bxiw_setup_module_dir}'"

    # Tag files:
    bxiw_tag_downloaded="${bxiw_tag_dir}/downloaded.tag"
    bxiw_tag_source="${bxiw_tag_dir}/source.tag"
    bxiw_tag_configured="${bxiw_tag_dir}/configured.tag"
    bxiw_tag_built="${bxiw_tag_dir}/built.tag"
    bxiw_tag_installed="${bxiw_tag_dir}/installed.tag"

    if [ ${bxiw_delete_tags} == true ]; then
	bxiw_log_info "_bxiw_prepare_post: Deleting existing tag files..."
	rm -f ${bxiw_tag_dir}/*.tag
    fi

    if [ ! -d ${bxiw_cache_dir} ]; then
	mkdir -p ${bxiw_cache_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "_bxiw_prepare_post: Cannot create the '${bxiw_cache_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "_bxiw_prepare_post: Cache directory '${bxiw_cache_dir}' is created!"
	fi
    else
	bxiw_log_info "_bxiw_prepare_post: Cache directory '${bxiw_cache_dir}' already exists!"
    fi

    if [ ${bxiw_do_rebuild} == true -a -d ${bxiw_build_dir} ]; then
	bxiw_log_info "_bxiw_prepare_post: Removing existing '${bxiw_build_dir}' build directory..."
	rm -fr ${bxiw_build_dir}
    fi

    if [ ! -d ${bxiw_build_dir} ]; then
	mkdir -p ${bxiw_build_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "_bxiw_prepare_post: Cannot create the '${bxiw_build_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "_bxiw_prepare_post: Build directory '${bxiw_build_dir}' is created!"
	fi
    fi

    if [ ! -d ${bxiw_tag_dir} ]; then
	mkdir -p ${bxiw_tag_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "_bxiw_prepare_post: Cannot create the '${bxiw_tag_dir}' directory!"
	    return 1
	else
	    bxiw_log_info "_bxiw_prepare_post: Build directory '${bxiw_tag_dir}' is created!"
	fi
    fi

    if [ ${bxiw_with_package} == true ]; then
	bxiw_system_install=true
	if [ ! -d ${bxiw_package_dir} ]; then
	    mkdir -p ${bxiw_package_dir}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "_bxiw_prepare_post: Cannot create the '${bxiw_package_dir}' directory!"
		return 1
	    else
		bxiw_log_info "_bxiw_prepare_post: Package directory '${bxiw_package_dir}' is created!"
	    fi
	fi
    fi

    if [ ${bxiw_system_install} == true ]; then
	bxiw_install_dir="/usr"
    else
	if [ ! -d ${bxiw_install_base_dir} ]; then
	    mkdir -p ${bxiw_install_base_dir}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "_bxiw_prepare_post: Cannot create the '${bxiw_install_base_dir}' directory!"
		return 1
	    else
		bxiw_log_info "_bxiw_prepare_post: Installation base directory '${bxiw_install_base_dir}' was created!"
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
    	    bxiw_log_error "_bxiw_prepare_post: Creation of directory '${bxiw_setup_module_dir}' failed!"
	    return 1
	else
	    bxiw_log_info "_bxiw_prepare_post: Setup directory '${bxiw_setup_module_dir}' is created!"
	fi
    fi

    if [ ! -d ${bxiw_setup_external_dir} ]; then
	mkdir -p ${bxiw_setup_external_dir}
	if [ $? -ne 0 ]; then
    	    bxiw_log_error "_bxiw_prepare_post: Creation of directory '${bxiw_setup_external_dir}' failed!"
	    return 1
	else
	    bxiw_log_info "_bxiw_prepare_post: Setup directory '${bxiw_setup_external_dir}' is created!"
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
	bxiw_builder="make" # Alternative is 'ninja'
    fi

    if [ ${__bxiw_enable_source_from_git} == true -a ${bxiw_source_from_git} == true ]; then
	if [ "x${bxiw_source_git_branch}" == "x" ]; then
	    bxiw_source_git_branch="develop"
	fi
     fi

    if [ "x${bxiw_package_version}" = "x" ]; then
	if [ ${__bxiw_enable_source_from_git} == true -a ${bxiw_source_from_git} == true ]; then
	    bxiw_package_version="${bxiw_source_git_branch}"
	else
	    bxiw_package_version="${bxiw_default_package_version}"
	fi
    fi

    bxiw_log_info "Checking support of the requested package version '${bxiw_package_version}' ..."
    # local _listSupportedVersions="$(echo ${bxiw_supported_package_versions} | tr [[:space:]] ' ' | tr -s ' ' | tr ' ' '\n')"
    local _versionIsSupported=false
    for _pkgSupportedVersion in ${bxiw_supported_package_versions} ; do
	if [ "x${_pkgSupportedVersion}" = "x${bxiw_package_version}" ]; then
	    _versionIsSupported=true
	    break
	fi
    done
    if [ ${_versionIsSupported} = false ]; then
	bxiw_exit 1 "Requested package version '${bxiw_package_version}' is not supported!"
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

    if [ "x${bxiw_setup_external_dir}" = "x" ]; then
	bxiw_setup_external_dir="${bxiw_setup_dir}/external"
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
    bxiw_log_info "  - enable source from Git = ${__bxiw_enable_source_from_git}"
    bxiw_log_info "  - disable package        = ${__bxiw_disable_package} (deprecated)"
    bxiw_log_info "  - enable packaging       = ${__bxiw_enable_packaging} (not used yet)"
    bxiw_log_info "bxiw_os_name             = '${bxiw_os_name}'"
    bxiw_log_info "bxiw_os_arch             = '${bxiw_os_arch}'"
    bxiw_log_info "bxiw_os_distrib_id       = '${bxiw_os_distrib_id}'"
    bxiw_log_info "bxiw_os_distrib_release  = '${bxiw_os_distrib_release}'"
    bxiw_log_info "bxiw_package_name        = '${bxiw_package_name}'"
    if [ ${__bxiw_enable_source_from_git} == true ]; then
	bxiw_log_info "bxiw_source_from_git        = ${bxiw_source_from_git}"
	bxiw_log_info "bxiw_source_git_path        = '${bxiw_source_git_path}'"
	bxiw_log_info "bxiw_source_git_branch      = '${bxiw_source_git_branch}'"
    fi
    bxiw_log_info "bxiw_package_version     = '${bxiw_package_version}'"
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
    bxiw_log_info "bxiw_build_dir           = '${bxiw_build_dir}'"
    bxiw_log_info "bxiw_install_dir         = '${bxiw_install_dir}'"
    bxiw_log_info "bxiw_do_reconfigure      = ${bxiw_do_reconfigure}"
    bxiw_log_info "bxiw_no_build            = ${bxiw_no_build}"
    bxiw_log_info "bxiw_do_rebuild          = ${bxiw_do_rebuild}"
    bxiw_log_info "bxiw_remove_build_dir    = ${bxiw_remove_build_dir}"
    bxiw_log_info "bxiw_remove_tarballs     = ${bxiw_remove_tarballs}"
    bxiw_log_info "bxiw_no_install          = ${bxiw_no_install}"
    if [ ${__bxiw_disable_package} == false ]; then
	bxiw_log_info "bxiw_package_dir         = '${bxiw_package_dir}'"
	bxiw_log_info "bxiw_with_package        = ${bxiw_with_package}"
	bxiw_log_info "bxiw_pkg_maintener_email = '${bxiw_pkg_maintener_email}'"
	bxiw_log_info "bxiw_pkg_release         = '${bxiw_pkg_release}'"
    fi
    return 0
}


function bxiw_git_clone_and_branch()
{
    local _opwd=$(pwd)
    local _git_url="$1"
    shift 1
    local _git_branch="$1"
    shift 1
    local _git_local_dir="$1"
    shift 1
    bxiw_log_trace "Git repository URL       : '${_git_url}'"
    bxiw_log_trace "Git branch               : '${_git_branch}'"
    bxiw_log_trace "Git local copy directory : '${_git_local_dir}'"
    bxiw_cache_git_dir=${bxiw_cache_dir}/${_git_local_dir}
    if [ ! -d ${bxiw_cache_git_dir} ]; then
	cd ${bxiw_cache_dir}
	bxiw_log_info "Cloning '${_git_url}' into '${_git_local_dir}'..."
	git clone ${_git_url} ${bxiw_cache_git_dir}
	if [ $? -ne 0 ]; then
	    bxiw_log_error "Cannot clone '${_git_url}' repository!"
	    cd ${_opwd}
	    return 1
	fi
	if [ "x${_git_branch}" != "x" ]; then
	    cd ${bxiw_cache_git_dir}
	    git checkout ${_git_branch}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "Cannot checkout branch '${_git_branch}'!"
		cd ${_opwd}
		return 1
	    fi
	fi
    else
	bxiw_log_info "Git local copy directory '${_git_local_dir}' already exists in '${bxiw_cache_dir}'!"
    fi
    cd ${_opwd}
    return 0
}


function bxiw_download_file()
{
    local _opwd=$(pwd)
    local _url="$1"
    shift 1
    local _local_file="$1"
    shift 1
    local _remote_file=""
    bxiw_log_info "bxiw_download_file: URL : '${_url}'"
    bxiw_log_info "bxiw_download_file: File to be dowloaded : '${_local_file}'"
    bxiw_log_info "bxiw_download_file: Cache dir : '${bxiw_cache_dir}'"
    if  [ "x${_local_file}" = "x" ]; then
	_local_file="$(echo ${_url} | tr '/' '\n' | tail -1)"
	bxiw_log_info "bxiw_download_file: Default local filename : '${_local_file}'"
    fi
    if  [ "x${_remote_file}" = "x" ]; then
	_remote_file="$(echo ${_url} | tr '/' '\n' | tail -1)"
	bxiw_log_info "bxiw_download_file: Remote filename : '${_remote_file}'"
    fi
    if [ -f ${bxiw_cache_dir}/${_local_file} ]; then
	bxiw_log_info "bxiw_download_file: File '${_local_file}' already exists in '${bxiw_cache_dir}'!"
	rm -f ${bxiw_cache_dir}/${_local_file}
    fi
    if [ ! -f ${bxiw_cache_dir}/${_local_file} ]; then
	cd ${bxiw_cache_dir}
	local _thisDir=$(pwd)
	bxiw_log_info "bxiw_download_file: Current directory = '${_thisDir}'..."
	bxiw_log_info "bxiw_download_file: Downloading file '${_local_file}' from remote '${_url}'..."
	if [ "${_url:0:5}" = "file:" ]; then
	    cp -f "${_url:5}" "${bxiw_cache_dir}/${_local_file}"
	    if [ $? -ne 0 ]; then
		bxiw_log_error "bxiw_download_file: Cannot copy '${_remote_file}' file from filesystem to target directory!"
		cd ${_opwd}
		return 1		
	    fi
	else
	    wget ${_url}
	    if [ $? -ne 0 ]; then
		bxiw_log_error "bxiw_download_file: Cannot download the '${_remote_file}' file!"
		cd ${_opwd}
		return 1
	    else
		bxiw_log_info "bxiw_download_file: Downloaded file = '${_remote_file}'"
		if [ "x${_local_file}" != "x${_remote_file}" ]; then
		    if [ -f ./${_local_file} ]; then
			bxiw_log_info "bxiw_download_file: Removing previous local file = '${_local_file}'"
			rm -f ./${_local_file}
		    fi
		    mv -f ./${_remote_file} ./${_local_file}
		fi
	    fi
	    # wget ${_url} -O "${bxiw_cache_dir}/${_local_file}"
	    # if [ $? -ne 0 ]; then
	    # 	bxiw_log_error "bxiw_download_file: Cannot download the '${_local_file}' file!"
	    # 	cd ${_opwd}
	    # 	return 1
	    # else
	    # 	bxiw_log_info "bxiw_download_file: Downloaded file : '${_local_file}'"
	    # fi
	fi
    fi
    # tree ${bxiw_cache_dir}
    if [ ! -f ${bxiw_cache_dir}/${_local_file} ]; then
	bxiw_log_error "bxiw_download_file: No file '${_local_file}'!"
	cd ${_opwd}
	return 1
    fi
    if [ "x${bxiw_downloaded_files}" = "x" ]; then
	bxiw_downloaded_files="${_local_file}"
    else
	bxiw_downloaded_files="${bxiw_downloaded_files}|${_local_file}"
    fi
    cd ${_opwd}
    return 0
}

function bxiw_clean_at_end()
{
    if [ -d ${bxiw_tag_dir} ]; then
	rm -fr ${bxiw_tag_dir}
    fi
    if [ -d ${bxiw_build_dir} ]; then
	rm -fr ${bxiw_build_dir}
    fi
    # if [ "x${bxiw_downloaded_files}" != "x" ]; then
    # 	local _dfiles=$(cut -d'|' ${bxiw_downloaded_files})
    # 	for _dfFile  in ${_dffiles} ; do
    # 	    bxiw_log_info "bxiw_clean_at_end: Remove downloaded file '${_dfFile}'"
    # 	done 	    		  	      
    # fi
    return 0
}

### export __libbxiw_loaded=1
### fi # __libbxiw_loaded

# end

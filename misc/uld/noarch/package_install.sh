#!/bin/sh

SCRIPTS_DIR="$(dirname "$0")"

# load 'scripting' run-time support utility functions
. "${SCRIPTS_DIR}/scripting_utils"

# load 'package' run-time support utility functions
. "${SCRIPTS_DIR}/package_utils"

#. "${SCRIPTS_DIR}/packet.sh"
environment_init $(basename "$0" ".sh")

if [ $# -ne 1 ] ; then
	show_nls_message "**** Usage: \${0} package"
	exit 1
fi
load_package "$1"


MISSING_REQUIREMENTS="$(get_missing_requirements)"
log_variable MISSING_REQUIREMENTS
if [ -n "${MISSING_REQUIREMENTS}" ] ; then
	report_missing_requirements "${MISSING_REQUIREMENTS}"
	exit 1
fi

IS_INSTALL_NECESSARY="$(isInstallNecessary)"
log_variable IS_INSTALL_NECESSARY
if ! ${IS_INSTALL_NECESSARY} ; then
	report_no_install_reason
	log_message "Skipping package '${PACKAGE_NAME}'/'$(dist_version)' installation since version '$(version)' is already installed"
	exit 0
fi

if ! have_root_permissions ; then
	show_nls_message "**** Root privileges are required"
	exit 1
fi

# attempt to install dependencies
DEPENDENCIES="$(dependencies)"
log_variable DEPENDENCIES
for DEPENDENCY in ${DEPENDENCIES} ; do
        log_message "invoking: ${SCRIPTS_DIR}/package_install.sh" "${DEPENDENCY}"
        if ! "${SCRIPTS_DIR}/package_install.sh" "${DEPENDENCY}" ; then
		log_message "dependency installation failure"
		exit 1
	fi
done

log_message "removing previously installed files (if present)"
remove_package_files

# register package as dependency
register_dependency

# package specific install
log_message "installing package"
do_install

# install version file (if available)
DIST_VERSION_FILE="$(_dist_version_file "${PACKAGE_NAME}" "${PACKAGE_SUFFIX}")"
log_variable DIST_VERSION_FILE
if [ -r "${DIST_VERSION_FILE}" ] ; then
	VERSION_FILE="$(_version_file "${PACKAGE_NAME}" "${PACKAGE_SUFFIX}")"
	log_variable VERSION_FILE
	install_p "${DIST_VERSION_FILE}" "${VERSION_FILE}" 2>&1 | log_redirected_output
else
	log_message "'${DIST_VERSION_FILE}' is unavailable"
fi

# report end of install
after_install

log_message "finished"

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


if ! have_root_permissions ; then
	show_nls_message "**** Root privileges are required"
	exit 1
fi


# check if uninstall is possible (i.e. there are no "dependants")
if ! isUninstallPossible; then
	log_message "uninstall is not possible"
	exit 1
fi

# package specific uninstall
do_uninstall

# remove package files
remove_package_files

# remove package install directory (if possible)
log_variable INSTALL_BASE_DIR
INSTALL_SUBDIR="$(_install_subdir "${PACKAGE_NAME}" "${PACKAGE_SUFFIX}")"
log_variable INSTALL_SUBDIR
log_message "( cd ${INSTALL_BASE_DIR} && rmdir -p ${INSTALL_SUBDIR} )"
( cd "${INSTALL_BASE_DIR}" && rmdir -p "${INSTALL_SUBDIR}" ) 2>/dev/null

# attempt to uninstall dependencies
DEPENDENCIES="$(dependencies)"
log_variable DEPENDENCIES
for DEPENDENCY in ${DEPENDENCIES} ; do
	log_message "invoking: ${SCRIPTS_DIR}/package_uninstall.sh" "${DEPENDENCY}"
	"${SCRIPTS_DIR}/package_uninstall.sh" "${DEPENDENCY}"
done

# report end of uninstall
after_uninstall

log_message "finished"

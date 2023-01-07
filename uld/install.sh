#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")/noarch

# load 'scripting' run-time support utility functions
. "${SCRIPTS_DIR}/scripting_utils"
script_log_init $(basename "$0" ".sh")

# load 'package' run-time support utility functions
. "${SCRIPTS_DIR}/package_utils"
environment_init $(basename "$0" ".sh")

if sh "$SCRIPTS_DIR/pre_install.sh" "$@" ; then
	if sh "$SCRIPTS_DIR/package_install.sh" "printer-meta" ; then
		# CUPS - OK
		sh "$SCRIPTS_DIR/package_install.sh" "scanner-meta"
	else
		# CUPS - NG
		show_nls_message_no_nl "**** Do you want to continue to install scan driver ? [y/n] : "
		if [ -z "${CONTINUE_INSTALL}" ] ; then
			read CONTINUE_INSTALL
		fi
		if [ "y" = "${CONTINUE_INSTALL}" ] || [ "Y" = "${CONTINUE_INSTALL}" ] ; then
			sh "$SCRIPTS_DIR/package_install.sh" "scanner-meta"
		fi
	fi
	sh "$SCRIPTS_DIR/post_install.sh" "$@"
fi

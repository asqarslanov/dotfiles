#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")/noarch

# load 'scripting' run-time support utility functions
. "${SCRIPTS_DIR}/scripting_utils"
script_log_init $(basename "$0" ".sh")

if sh "$SCRIPTS_DIR/pre_install.sh" "$@" -u ; then
	sh "$SCRIPTS_DIR/package_uninstall.sh" "printer-meta"
	sh "$SCRIPTS_DIR/post_install.sh" "$@" -u
fi

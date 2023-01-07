#!/bin/sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

SCRIPTS_DIR="$(dirname "$0")"

# load 'scripting' run-time support utility functions
. "${SCRIPTS_DIR}/scripting_utils"

# load 'package' run-time support utility functions
. "${SCRIPTS_DIR}/package_utils"
environment_init "$(basename "$0" ".sh")"


UNINSTALLMODE=
while [ -n "$1" ]; do
	case "$1" in
	-u) UNINSTALLMODE=1 ;;
	vendor=*) specify_vendor "${1#vendor=}" ;;
	*) break ;;
	esac
	shift
done

if [ "$UNINSTALLMODE" ]; then
	show_nls_message "**** Uninstall finished."
else
	show_nls_message "**** Install finished."
fi

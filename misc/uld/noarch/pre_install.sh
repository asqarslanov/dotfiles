#!/bin/sh

compare_insensitive() {
	echo "$1" | grep -qi "^${2}$"
}

detect_legacy_uld() {
	if ! [ -d "/opt" ] ; then
		return 1
	fi

	for i in $( ls "/opt" ) ; do
		if compare_insensitive $i $VENDOR ; then
			if [ -s "/opt/$i/mfp/uninstall/guiuninstall" ]; then
				LEGACY_ULD_NAME="$i"
				return 0
			fi
		fi
	done
	return 1
}

# lecence file finding
find_eula_file() {
	EULA_DIR="${DIST_DIR}/noarch/license"
	log_variable EULA_DIR

	EULA_LOCALE="${LC_ALL:-${LC_MESSAGES:-${LANG}}}"
	EULA_LOCALE=`echo "${EULA_LOCALE}" | tr A-Z a-z`
	log_variable EULA_LOCALE

	while [ -n "${EULA_LOCALE}" ] ; do
		EULA_FILE="${EULA_DIR}/eula-${EULA_LOCALE}.txt"
		#log_variable EULA_FILE
		if [ -r "${EULA_FILE}" ] ; then break ; fi
		EULA_LOCALE=`echo "${EULA_LOCALE}" | sed 's/.$//'` # drop last symbol
	done
	log_variable EULA_LOCALE
	if [ -z "${EULA_LOCALE}" ] ; then
		EULA_FILE="${EULA_DIR}/eula.txt"
		if [ ! -r "${EULA_FILE}" ] ; then
			EULA_FILE=""
		fi
	fi

	log_variable EULA_FILE
	echo "${EULA_FILE}"
}

show_license() {
	EULA_FILE=`find_eula_file`
	EULA_PAGER="${PAGER:-`which more`}"
	log_variable EULA_PAGER

	if [ -n "${EULA_FILE}" -a -n "${EULA_PAGER}" ] ; then
		ICONV_BINARY=`which iconv`
		# show EULA:
		show_cut_line
		if [ -z "${SKIP_EULA_PAGER}" ] ; then
			if [ -n "$ICONV_BINARY" ] ; then
				cat "${EULA_FILE}" | "${ICONV_BINARY}" -c -f "UTF-8" | ${EULA_PAGER}
			else
				"${EULA_PAGER}" "${EULA_FILE}"
			fi
		fi

		show_cut_line

		# ask for agreement:
		output_blank_line
		show_nls_message_no_nl "**** Do you agree ? [y/n] : "
		if [ -z "${AGREE_EULA}" ] ; then
			read AGREE_EULA
		fi
		if [ "y" != "${AGREE_EULA}" ] && [ "Y" != "${AGREE_EULA}" ] ; then
			show_nls_message "**** Terminated by user"
			exit 1
		fi
	fi
}

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
	esac
	shift
done

if ! have_root_permissions ; then
	show_nls_message "**** Root privileges are required"
	exit 1
fi

if [ "$UNINSTALLMODE" ]; then
	show_nls_message "**** Running uninstall ..."
else
	show_nls_message "**** Running install ..."
fi
show_nls_message_no_nl "**** Press 'Enter' to continue or 'q' and then 'Enter' to quit. : "
if [ -z "${QUIT_INSTALL}" ] ; then
	read QUIT_INSTALL
fi
if [ "q" = "${QUIT_INSTALL}" ] || [ "Q" = "${QUIT_INSTALL}" ] ; then
	show_nls_message "**** Terminated by user"
	exit 1
fi

LEGACY_ULD_NAME=
if detect_legacy_uld ; then
	show_nls_message "**** Old version of Unified Linux Driver is detected."
	show_nls_message "**** In order to continue the installation, please remove old version."
	show_nls_message_no_nl "**** If you want to delete old version press 'y'. To finish the installation press 'Enter'. : "
	if [ -z "${UNINSTALL_LECAGY}" ] ; then
		read UNINSTALL_LECAGY
	fi
	if [ "y" = "${UNINSTALL_LECAGY}" ] || [ "Y" = "${UNINSTALL_LECAGY}" ] ; then
		"/opt"/${LEGACY_ULD_NAME}/mfp/uninstall/uninstall.sh -t
	else
		show_nls_message "**** Terminated by user"
		exit 1
	fi
fi

if ! [ "$UNINSTALLMODE" ]; then
	show_license
fi

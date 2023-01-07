#!/bin/sh
#
# @Usage:
#
# . ./firewall/firewall.sh
# make_hole_in_firewall [ port ]
# make_hole_in_firewall [ port ]
#

DEFAULT_SNMP_BROADCAST_PORT="22161"
FIREWALL_NAME_TEMPL="firewall-"

make_hole_in_firewall() {
	local path="."
	if [ -n "$1" ]; then
		path="$1"
	fi
	local PORT=$DEFAULT_SNMP_BROADCAST_PORT
	local FILE_LIST="$(ls "$path/$FIREWALL_NAME_TEMPL"*)"

	for i in $FILE_LIST	; do
		. $i
		make_hifw_${i#*${FIREWALL_NAME_TEMPL}} $PORT
	done
}

plug_hole_in_firewall() {
	local path="."
	if [ -n "$1" ]; then
		path="$1"
	fi
	local PORT=$DEFAULT_SNMP_BROADCAST_PORT
	local FILE_LIST="$(ls "$path/$FIREWALL_NAME_TEMPL"*)"


	for i in $FILE_LIST	; do
		. "$i"
		plug_hifw_${i#*${FIREWALL_NAME_TEMPL}} $PORT
	done
}

test_iptables() {
	log_message "TEST IPTABLES"
	/sbin/iptables -L
	log_message "TEST IP6TABLES"
	/sbin/ip6tables -L
}



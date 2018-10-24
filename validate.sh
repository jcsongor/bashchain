#!/bin/bash
while read block;do
	if [ -n "${previous_block}" ];then
		checksum=`echo "${previous_block##*:}:${block%:*}"|sha256sum|sed 's/[ -]*$//'`
		if [ "${checksum}" != "${block##*:}" -o $(("${previous_block%%:*}" +1 )) -ne "${block%%:*}" ];then
			echo "Invalid block #${block%%:*}">&2;exit 1
		fi
	fi
	previous_block=$block
done<database

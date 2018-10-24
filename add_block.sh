#!/bin/bash
payload=`echo "${1}"|head -n1|tr -d ':'`
previous_block=`tail -n1 'database'`
id=$((${previous_block%%:*}+1))
while : ; do
	nonce=$RANDOM
	checksum=`echo "${previous_block##*:}:$id:$payload:$nonce"|sha256sum|sed 's/[ -]*$//'`
	[[ "${checksum: -2}" == '00' ]] && break;
done
echo "$id:$payload:$nonce:$checksum">>'database'

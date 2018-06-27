#!/bin/bash

function checkNumber() {
	re='^[0-9]+([.][0-9]+)?$'
	if ! [[ $1 =~ $re ]]; then
        return 1
	fi
    return 0
}

function Convert() {

    if ! checkNumber $1; then
        echo "expect number but receive $1"
        return 1
    fi

	local gb=$((1024 * 1024 * 1024))
	local mb=$((1024 * 1024))
	local kb=1024

	if (($1 >= $gb)); then
		echo "$(($1 / $gb)) GB" 
	elif (($1 >= $mb)); then
		echo "$(($1 / $mb)) MB"
	else
		echo "$(($1 / $kb)) KB"
	fi
}

if [ "$0" = "$BASH_SOURCE" ]
then
	Convert $1
fi

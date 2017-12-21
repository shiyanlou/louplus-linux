#!/bin/bash

# check number
function checkNumber() {
	re='^[0-9]+([.][0-9]+)?$'
	if ! [[ $1 =~ $re ]]; then
		echo "expect number but receive $1" && exit 1
	fi
}

if [[ $# != 3 ]]; then
	echo "need 3 arguments like / 7 2" && exit 1
fi

# check operator
if ! [[ $1 == "*" || $1 == "/" || $1 == "+" || $1 == "-" ]]; then
	echo "expect operator * / + - but receive $!" && exit 1
fi

checkNumber $2
checkNumber $3

echo "scale=3;($2 $1 $3)" | bc
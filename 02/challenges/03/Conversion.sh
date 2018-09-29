#!/bin/bash

# 检查参数是否为数字
function checkNumber() {
	re='^[0-9]+(\.[0-9]+)?$'
	if ! [[ $1 =~ $re ]]; then
        return 1
	fi
    return 0
}

# 转换数字为最合适的显示单位
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
	elif (($1 >= $kb)); then
		echo "$(($1 / $kb)) KB"
	else
		echo "$1 B"
	fi
}

# 调用 Convert 函数，直接传递所有脚本参数给函数
Convert $*

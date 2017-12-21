#!/bin/awk -f

# function to convert network unit
function convert(count) {
    gb = 1024 * 1024 * 1024
    mb = 1024 * 1024
    kb = 2014 * 1024
    if (count >= gb) {
        result = count / gb
        return int(result)"GB"
    } else if (count >= mb) {
        result = count / mb
        return int(result)"MB"
    } else {
        result = count / kb
        return int(result)"KB"
    }
}

NR > 2 {
    num[$1] = $10
}

END {
    for (i in num) {
        printf("%s %s\n", i, convert(num[i]))
    }
}

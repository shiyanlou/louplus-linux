#!/bin/awk -f

{
    num[$1]++
}

END {
    for (i in num) {
        printf("%d %s\n", array[i], i) | "sort -n -k1"
    }
}
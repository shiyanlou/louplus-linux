#!/bin/awk -f

BEGIN{ getline; }
{
    num[$1]++
}

END {
    for (i in num) {
        printf("%d %s\n", num[i], i) | "sort -n -k1"
    }
}

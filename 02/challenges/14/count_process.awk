#!/bin/awk -f

BEGIN {
  printf("%5s\t%-s\n", "COUNT", "USER")
}

NR>1 {
    num[$1]++
}

END {
    for (i in num) {
        printf("%5d\t%-s\n", num[i], i) | "sort -r -n -k1"
    }
}

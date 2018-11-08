#!/bin/awk -f

# 打印列名
BEGIN {
  printf("%5s\t%-s\n", "COUNT", "USER")
}

# 跳过 ps 命令输出的第一行，然后按每行的第一列（用户名）来分组计数
NR>1 {
    num[$1]++
}

# 最后打印每个用户的统计结果，并发送给 sort 命令排序后输出
# 注意 Awk 的管道会先把输入缓存起来，待管道关闭时再一次性发送给后面的命令处理，后面的 Shell 命令必须使用引号括起来
END {
    for (i in num) {
        printf("%5d\t%-s\n", num[i], i) | "sort -r -n -k1"
    }
}

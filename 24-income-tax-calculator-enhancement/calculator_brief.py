#!/usr/bin/env python3
# -*- codingLutf-8 -*-
import sys


def main():
    info = [
        [1500, 0.03, 0],
        [4500, 0.1, 105],
        [9000, 0.2, 555],
        [35000, 0.25, 1005],
        [55000, 0.3, 2755],
        [80000, 0.35, 5505],
        [float('inf'), 0.45, 13505]
    ]
    for each in sys.argv[1:]:
        uid, wage = each.split(':')
        try:
            wage = int(wage)
        except ValueError:
            print('Parameter Error')
        else:
            for i in info:
                if (1 - 0.165) * wage - 3500 <= i[0]:
                    print('%s:%.2f' % (uid, max(0, ((1 - 0.165) * wage - max(0, ((1 - 0.165) * wage - 3500)) * i[1] + i[2]))))
                    break


if __name__ == '__main__':
    main()

#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import glob

# 每种协议的所有连接对应的内存文件路径
PROC_FILE = {
    'tcp': '/proc/net/tcp',
    'tcp6': '/proc/net/tcp6',
    'udp': '/proc/net/udp',
    'udp6': '/proc/net/udp6'
}

# 连接状态码对应的描述
STATUS = {
    '01': 'ESTABLISHED',
    '02': 'SYN_SENT',
    '03': 'SYN_RECV',
    '04': 'FIN_WAIT1',
    '05': 'FIN_WAIT2',
    '06': 'TIME_WAIT',
    '07': 'CLOSE',
    '08': 'CLOSE_WAIT',
    '09': 'LAST_ACK',
    '0A': 'LISTEN',
    '0B': 'CLOSING'
}


def get_content(type):
    """
    读取指定协议的连接文件内容，去掉第一行表头
    """

    with open(PROC_FILE[type], 'r') as file:
        content = file.readlines()
        content.pop(0)
    return content


def get_program_name(pid):
    """
    从进程信息文件里获得指定进程的名字
    """

    path = '/proc/' + str(pid) + '/comm'
    with open(path, 'r') as file:
        content = file.read()
    content = content.strip()
    return content


def convert_ip_port(ip_port):
    """
    将十六进制的 IP 和 Port 字符串转换为十进制的整数
    """

    ip, port = ip_port.split(':')
    port = int(port, 16)
    ip = [str(int(ip[6:8], 16)), str(int(ip[4:6], 16)), str(int(ip[2:4], 16)),
          str(int(ip[0:2], 16))]
    ip = '.'.join(ip)
    return ip, port


def get_pid(inode):
    """
    从进程描述符信息文件里查找指定的 inode 号，从而得到进程 ID
    """

    # 搜索所有进程描述符文件列表
    for path in glob.glob('/proc/[0-9]*/fd/[0-9]*'):
        try:
            # 如果描述符文件为连接，则其为符号链接并且链接目标里包含 inode 号
            # 如果该 inode 号在某个进程的某个描述符文件路径里，则返回该进程 ID
            if str(inode) in os.readlink(path):
                # 从描述符文件路径里提取进程 ID
                return path.split('/')[2]
            else:
                continue
        except:
            pass
    return None


def main(choose):
    """
    打印指定协议的连接列表
    """

    # 获取原始的连接信息
    content = get_content(choose)

    # 依次解析每一行原始连接信息
    for info in content:
        # 按空白字符分隔
        iterms = info.split()
        # 协议
        proto = choose
        # 本地 IP 和端口
        local_address = "%s:%s" % convert_ip_port(iterms[1])
        # 连接状态
        status = STATUS[iterms[3]]
        # 远程 IP 和端口
        if status == 'LISTEN':
            remote_address = '-'
        else:
            remote_address = "%s:%s" % convert_ip_port(iterms[2])
        # 进程 ID
        pid = get_pid(iterms[9])
        # 进程名字
        program_name = ''
        if pid:
            program_name = get_program_name(pid)
        # 打印解析后的连接信息
        print(templ % (proto, local_address, remote_address,
                       status, pid or '-', program_name or '-', ))


if __name__ == '__main__':
    choose = 'all'
    if len(sys.argv) > 1:
        choose = sys.argv[1]

    # 打印表头
    templ = "%-5s %-30s %-30s %-13s %-6s %s"
    print(templ % ("Proto", "Local address",
                   "Remote address", "Status", "PID", "Program name"))

    # 打印指定协议或所有协议的连接信息
    if choose == "all":
        for k in PROC_FILE:
            main(k)
    else:
        main(choose)

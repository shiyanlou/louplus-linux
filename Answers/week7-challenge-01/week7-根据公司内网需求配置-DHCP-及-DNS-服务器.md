# 挑战：根据公司内网需求配置 DHCP 及 DNS 服务器

## DHCP 配置

```bash
cd /home/shiyanlou
wget https://labfile.oss.aliyuncs.com/courses/2657/dhcpd.conf
sudo mv dhcpd.conf /etc/dhcp/
```

向 `/etc/dhcp/dhcpd.conf` 文件末尾添加如下内容：

```conf
subnet 192.168.42.0 netmask 255.255.255.0 {
    range 192.168.42.50 192.168.42.150;
    option routers 192.168.42.1;
    
    host shiyanlou-client {
        hardware ethernet 05:42:c0:a8:00:03;
        fixed-adddress 192.168.42.100;
    }
}
```

## DNS 配置

```bash
cd /home/shiyanlou
wget https://labfile.oss.aliyuncs.com/courses/2657/named.conf
sudo mv named.conf /etc/
```

向 `/etc/named.conf` 文件末尾添加如下内容：

```conf
zone "test-louplus.com" IN {
        type master;
        file "/var/named/test-louplus.zone";
};

zone "42.168.192.in-addr.arpa" IN {
        type master;
        file "/var/named/42.168.192.zone";
};
```

向 `/etc/resolv.conf` 文件第一行插入如下内容：

```conf
nameserver 127.0.0.1
```

新建目录：

```bash
sudo mkdir /var/named
```

新建 `/var/named/42.168.192.zone` 文件，并向其中写入如下内容：

```conf
@  IN  SOA  dns.test-louplus.com. admin.test-louplus.com. (
       2017122704
       21600
       3600
       604800
       86400 )
    
    IN    NS    dns.test-louplus.com.

100    IN    PTR    mail.test-louplus.com.
101    IN    PTR    dev.test-louplus.com.
102    IN    PTR    nfs.test-louplus.com.
103    IN    PTR    dns.test-louplus.com.
```

新建 `/var/named/test-louplus.zone` 文件，并向其中写入如下内容：

```conf
@  IN  SOA  dns.test-louplus.com. admin.test-louplus.com. (
       2017122704
       21600
       3600
       604800
       86400 )

@    IN    NS    dns

@    IN    MX    10    mail.test-louplus.com.

mail IN    A     192.168.42.100
dev  IN    A     192.168.42.101
nfs  IN    A     192.168.42.102
dns  IN    A     192.168.42.103
```

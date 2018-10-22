-- 为来自 localhost 机器的 root 用户设置密码 4nM1ruJNqL1D
SET PASSWORD FOR "root"@"localhost"=PASSWORD("4nM1ruJNqL1D");

-- 创建来自 localhost 机器的用户 shiyanlou，密码为 Xd4a8lKjeL9Z
CREATE USER "shiyanlou"@"localhost" IDENTIFIED BY "Xd4a8lKjeL9Z";

-- 分配 shiyanlou001 数据库里所有表的 SELECT 权限给来自 localhost 机器的用户 shiyanlou
GRANT SELECT ON `shiyanlou001`.* TO "shiyanlou"@"localhost";
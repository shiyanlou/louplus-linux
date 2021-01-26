# 挑战：修改数据表定义

sql 语句如下所示：

```sql
# 选择 shiyanlou001 数据表
USE shiyanlou001;

# 给表 student 增加一列 s_phone
ALTER TABLE `student` ADD COLUMN `s_phone` varchar(11);

# 修改 s_name 等于 shiyanlou1005 的这些记录的 s_phone 列的值为 12948623179
UPDATE `student` SET `s_phone`='12948623179' WHERE `s_name`='shiyanlou1005';
```
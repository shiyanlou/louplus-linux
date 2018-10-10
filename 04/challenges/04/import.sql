-- 创建数据库
CREATE DATABASE `shiyanlou-staging` CHARACTER SET=utf8;

-- 创建用户
CREATE USER "shiyanlou"@"localhost" IDENTIFIED BY "Xd4a8lKjeL9Z";

-- 分配权限
GRANT SELECT, UPDATE ON `shiyanlou-staging`.* TO "shiyanlou"@"localhost";

-- 选择数据库
USE `shiyanlou-staging`;

-- 创建表 shiyanlou_user
CREATE TABLE `shiyanlou_user`
(
    `id` INT(4) NOT NULL PRIMARY KEY,
    `name` CHAR(20)
);

-- 创建表 shiyanlou_course
CREATE TABLE `shiyanlou_course`
(
    `id` INT(4) NOT NULL PRIMARY KEY,
    `name` CHAR(64)
);

-- 创建表 shiyanlou_usercourse
CREATE TABLE `shiyanlou_usercourse` 
( 
    `id` INT(4) NOT NULL PRIMARY KEY auto_increment, 
    `user_id` INT, 
    `course_id` INT, 
    `study_time` INT, 
    FOREIGN KEY (`user_id`) REFERENCES `shiyanlou_user`(`id`), 
    FOREIGN KEY (`course_id`) REFERENCES `shiyanlou_course`(`id`)
);

-- 关闭外键检查，避免插入数据过程中因为表数据插入顺序导致的外键约束错误
SET foreign_key_checks=0;

-- 导入数据到表 shiyanlou_user
LOAD DATA INFILE '/home/shiyanlou/loudatabase/shiyanlou_user.csv'
    INTO TABLE `shiyanlou_user` CHARACTER SET utf8
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

-- 导入数据到表 shiyanlou_course
LOAD DATA INFILE '/home/shiyanlou/loudatabase/shiyanlou_course.csv'
    INTO TABLE `shiyanlou_course` CHARACTER SET utf8
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

-- 导入数据到表 shiyanlou_usercourse，由于文件里的数据少一列，需要显示指定文件里的数据对应的列信息
LOAD DATA INFILE '/home/shiyanlou/loudatabase/shiyanlou_usercourse.csv'
    INTO TABLE `shiyanlou_usercourse` CHARACTER SET utf8
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    (`user_id`, `course_id`, `study_time`);

-- 开启外键检查
SET foreign_key_checks=1;

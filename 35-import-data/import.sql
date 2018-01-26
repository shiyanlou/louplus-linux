create database `shiyanlou-staging` character set = utf8;

CREATE USER shiyanlou@localhost IDENTIFIED BY "Xd4a8lKjeL9Z";

grant select, update on shiyanlou-staging.* to shiyanlou@localhost;

use shiyanlou-staging；

create table shiyanlou_user
(
    id int(4) not null primary key ,
    name char(20)
);

create table shiyanlou_course
(
    id int(4) not null primary key,
    name char(64)
);

create table shiyanlou_usercourse 
( 
    id int(4) not null primary key auto_increment, 
    user_id int, 
    course_id int, 
    study_time int, 
    foreign key (user_id) references shiyanlou_user (id), 
    foreign key (course_id) references shiyanlou_course (id) 
);

set foreign_key_checks = 0;

load data infile '/home/shiyanlou/loudatabase/shiyanlou_user.csv' into table user character
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data infile '/home/shiyanlou/loudatabase/shiyanlou_course.csv' into table course character
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data infile '/home/shiyanlou/loudatabase/shiyanlou_usercourse.csv' into table usercourse character
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n' (user_id,course_id,study_time);

set foreign_key_checks = 1;
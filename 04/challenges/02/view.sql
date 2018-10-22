-- 连接用户表和用户课程关系表，按用户分组并统计总学习时间
CREATE VIEW `user_all_study_time` AS
    SELECT u.id AS `user_id`, u.name AS `user_name`, SUM(uc.study_time) AS `all_study_time`
    FROM `user` AS `u` INNER JOIN `usercourse` AS `uc` ON u.id=uc.user_id
    GROUP BY `user_id`
    ORDER BY `all_study_time`;

-- 连接课程表和用户课程关系表，按课程分组并统计总人数和总学习时间，最后按总学习时间倒序排序
CREATE VIEW `course_statistics` AS
    SELECT c.name AS `course_name`, COUNT(uc.user_id) AS `user_count`, SUM(uc.study_time) AS `all_study_time`
    FROM `course` AS `c` INNER JOIN `usercourse` AS `uc` ON c.id=uc.course_id
    GROUP BY `course_id`
    ORDER BY `all_study_time` DESC;
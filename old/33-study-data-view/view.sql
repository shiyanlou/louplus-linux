create view user_all_study_time
as
    select u.id as user_id, u.name as user_name, sum(uc.study_time) as all_study_time
    from user as u, usercourse as uc
    where u.id=uc.user_id
    group by uc.user_id
    order by all_study_time;

create view course_statistics
as
    select c.name as course_name, count(uc.user_id) as user_count, sum(uc.study_time) as all_study_time
    from course as c, usercourse as uc
    where c.id=uc.course_id
    group by uc.course_id
    order by all_study_time desc;
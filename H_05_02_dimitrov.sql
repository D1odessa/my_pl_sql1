-- 1 --
CREATE VIEW rep_project_dep_v AS

select et.*, t2.department_name, t2.emp_count,  t2.man_count, t2.sum_sal
from (   --таблица из файла
        SELECT ext_fl.project_id, ext_fl.project_name, ext_fl.department_id
        FROM EXTERNAL ( (   project_id NUMBER,
                            project_name VARCHAR2(100),
                            department_id NUMBER )
                TYPE oracle_loader DEFAULT DIRECTORY FILES_FROM_SERVER -- вказуємо назву директорії в БД
                ACCESS PARAMETERS ( records delimited BY newline
                                    nologfile
                                    nobadfile
                                    fields terminated BY ','
                                    missing field VALUES are NULL )
                LOCATION('PROJECTS.csv') --  файл источник
                REJECT LIMIT UNLIMITED /*немає обмежень для відкидання рядків*/ ) ext_fl ) et
        
join (          --таблица из нашей базы
        select t0.department_id, t0.emp_count, t0.man_count, t0.sum_sal, t1.department_name
        from (select em.department_id,count(em.department_id) as emp_count, sum(em.salary) as sum_sal,count(distinct(em.manager_id)) as man_count
                        from dima.employees em
                        group by em.department_id ) t0
                join  (select * from dima.departments dp) t1
                on t0.department_id = t1.department_id
        ) t2
on et.department_id = t2.department_id
;
        
-- tests--

select *
        from rep_project_dep_v tt;


-----


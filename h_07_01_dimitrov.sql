select  tt.region_name, count(tt.region_name) as emp_num
from (  select em.employee_id, em.department_id, rg.region_id, rg.region_name
        from hr.employees em
        join  hr.departments dp
            on em.department_id = dp.department_id
        join  hr.locations lc
            on dp.location_id = lc.location_id
        join hr.countries cn
            on lc.country_id = cn.country_id
        join hr.regions rg
            on cn.region_id = rg.region_id
--        where em.department_id = 60
        where em.department_id = null or null is null
        ) tt
group by tt.region_name
;


SELECT *
FROM TABLE(util.get_region_cnt_emp());

CREATE FUNCTION get_dep_name(p_employee_id IN NUMBER)  RETURN VARCHAR2 IS
    v_dep_name dima.departments.department_name%type;
    
BEGIN

    select dp.department_name
    into v_dep_name 
    from employees em
    join dima.departments dp
    on em.department_id = dp.department_id
    where em.employee_id = p_employee_id;
    
    RETURN v_dep_name;
END get_dep_name;
/


select em.employee_id, em.first_name, em.last_name, em.email, em.phone_number, em.hire_date, get_job_title(em.employee_id), em.salary, em.commission_pct, em.manager_id, get_dep_name(em.employee_id)
from dima.employees em;



-- TESTS

select get_dep_name(103)
from dual;

select em.*, get_job_title(em.employee_id),get_dep_name(em.employee_id)
from dima.employees em;

create table dima.departments as
select *
from hr.departments;

select *
from departments dp;
from employees em;
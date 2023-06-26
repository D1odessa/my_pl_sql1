DECLARE
    v_employee_id hr.employees.employee_id%TYPE := 150;
    v_job_id hr.jobs.job_id%TYPE;
    v_job_title hr.jobs.job_title%type;
BEGIN
    select em.job_id
        INTO v_job_id
    from hr.employees em
    where em.employee_id = v_employee_id;
        
    select jb.job_title
        INTO v_job_title
    from hr.jobs jb
    where jb.job_id = v_job_id;
              
   dbms_output.put_line('Должность сотрудника с id '||v_employee_id || ' : ' ||v_job_title);
END;
/

SELECT em.job_id
FROM hr.employees em
where em.employee_id = 110
;

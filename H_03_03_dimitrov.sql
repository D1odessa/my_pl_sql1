DECLARE
    v_emp_id NUMBER(10)  := 103;
    v_job_id VARCHAR2(10) :='IT_QA2';
    v_result VARCHAR2(100) ;
BEGIN
    dbms_output.put_line('emp_id ='|| v_emp_id || '; job =' ||util.get_job_title(p_employee_id=> v_emp_id  ));
    dbms_output.put_line('dep_name ='||util.get_dep_name( v_emp_id  ));
    
    util.del_jobs(v_job_id, v_result);
    dbms_output.put_line(v_result);
END;
/

drop PROCEDURE del_jobs;  
drop FUNCTION get_dep_name;
drop FUNCTION get_job_title;

select util.get_job_title(103 )as job, util.get_dep_name(103 ) as dep
    from dual;

 
    
  --tests--  
select *
from dima.jobs jb;
    



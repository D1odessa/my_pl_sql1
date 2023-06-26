PROCEDURE del_jobs (    p_job_id    IN VARCHAR2,
                        po_result   OUT VARCHAR2) IS
    v_job_id dima.jobs.job_id%type;                        
    BEGIN
        check_work_time;
        BEGIN
            select jb.job_id
            into v_job_id
            from dima.jobs jb
            where jb.job_id = p_job_id;
        
             delete from dima.jobs jb
             where jb.job_id = p_job_id;
             COMMIT;    
             po_result := 'Посада '||p_job_id||' успішно видалена';
            
        EXCEPTION
            WHEN no_data_found THEN
                raise_application_error(-20004, '"Посада '|| p_job_id ||' не існує"(код помилки -20004)');
                        
        END;
    END del_jobs;
/   
    
    
---------TESTS---
DECLARE
    v_op VARCHAR2(120);
BEGIN
   util.del_jobs('IT_QA6', v_op);
   dbms_output.put_line(v_op);
end;
/
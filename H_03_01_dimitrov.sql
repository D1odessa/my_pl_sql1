create or replace PROCEDURE del_jobs ( p_job_id    IN VARCHAR2,
                                       po_result   OUT VARCHAR2) IS
                            
    v_is_exist_job NUMBER;
BEGIN
    
    select count(jb.job_id)
    into v_is_exist_job
    from dima.jobs jb
    where jb.job_id = p_job_id;

    IF v_is_exist_job = 0 THEN
        po_result := 'Посада '|| p_job_id ||' не існує';
    ELSE
        delete from dima.jobs jb
        where jb.job_id = p_job_id;
        --COMMIT;    -- СДЕЛАЛ без сохранения
        po_result := 'Посада '||p_job_id||' успішно видалена';
    END IF;
END del_jobs;
/

--TESTS

select *
from dima.jobs jb;

DECLARE
    v_err varchar2(100);
begin
    del_jobs ( p_job_id       => 'IT_QA2',
               po_result      => v_err);
     -- del_jobs('IT_QA3', v_err);            
    dbms_output.put_line(v_err);
end;
/
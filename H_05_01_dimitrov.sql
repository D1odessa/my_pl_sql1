
CREATE OR REPLACE TRIGGER hire_date_update
    BEFORE UPDATE ON dima.employees
    FOR EACH ROW
    
DECLARE
        PRAGMA autonomous_transaction;
   
BEGIN
    IF :OLD.job_id != :NEW.job_id THEN
        
                :NEW.hire_date := TRUNC(SYSDATE);
                
                
        END IF;
    COMMIT;
END hire_date_update;
/


----TESTS---

UPDATE dima.employees em
    SET em.job_id = 'ST_MAN18'
    WHERE em.employee_id = 121;
    
select *
from employees em
where employee_id = 121;


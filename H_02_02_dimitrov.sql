DECLARE
    v_def_percent VARCHAR2(30);
    v_percent VARCHAR2(5);
    
BEGIN
    FOR cc IN (SELECT em.FIRST_NAME ||' ' || em.LAST_NAME as emp_name,
                COMMISSION_PCT*100 as percent_of_salary,
                em.manager_id
               FROM hr.employees em
               where em.department_id = 80
               order by emp_name) LOOP
               
        IF cc.manager_id = 100 THEN
            dbms_output.put_line('�������� '||cc.emp_name || ', ������� �� �������� �� ����� �����������');
           -- EXIT; -- ����� � �����
           CONTINUE;
           
        ELSIF cc.percent_of_salary >=10 and cc.percent_of_salary <=20 then
               v_def_percent := '���������';
              
        ELSIF cc.percent_of_salary >=25 and cc.percent_of_salary <=30 then
               v_def_percent := '�������';
             
        ELSIF cc.percent_of_salary >=35 and cc.percent_of_salary <=40 then
               v_def_percent := '������������';
             
        END IF;
        
        v_percent := CONCAT(cc.percent_of_salary, '%');
        dbms_output.put_line('�������� '|| cc.emp_name||'; ������� �� �������� - '|| v_percent||'; ���� �������� - ' ||v_def_percent);
    END LOOP;
              
END;
/

SELECT em.FIRST_NAME ||' ' || em.LAST_NAME as emp_name, COMMISSION_PCT*100 as percent_of_salary
       , em.manager_id
FROM hr.employees em
where em.department_id = 80
order by emp_name
;

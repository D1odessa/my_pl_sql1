DECLARE
    v_year number(6) := 2013;
    v_check_year number(2);
BEGIN
   v_check_year := mod(v_year, 4);
    IF v_check_year = 0 
    THEN
        dbms_output.put_line('���������� ��');
    ELSE
        dbms_output.put_line('�� ���������� ��');
END IF;
END;
/
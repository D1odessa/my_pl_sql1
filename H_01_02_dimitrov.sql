DECLARE
    v_date date := sysdate;
    v_day number(2);
BEGIN
    --v_date  := TO_DATE('30.06.2023', 'DD.MM.YYYY');
    v_day := to_number(to_char(v_date, 'dd'));
    IF v_date = (last_day(trunc(SYSDATE))) 
        THEN
        dbms_output.put_line('������� ��' );
    ElSIF v_day = 15  THEN
        dbms_output.put_line('������� ������');
    ElSIF v_day < 15  THEN
        dbms_output.put_line('������ �� �����');
    ElSIF v_day > 15  THEN
        dbms_output.put_line('������ �� ��');
    END IF;
END;
/
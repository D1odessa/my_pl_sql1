--Отправить отчет по номеру id сотрудника

declare
 v_mes VARCHAR2(100);
begin
    send_email_rep(500,v_mes);      --отправка мне
    
--    send_email_rep(510,v_mes);      --отправка Косте на kastanta91usb
    
    dbms_output.put_line('Результат: ' ||v_mes);
end;
/



---------
CREATE PROCEDURE send_email_rep (   p_emp_id    IN NUMBER,
                                    po_result      OUT VARCHAR2) IS

    v_emp_id NUMBER  ;
    v_emp_name VARCHAR2(100);

    v_recipient VARCHAR2(50);                --адрес email
    v_subject VARCHAR2(50) := 'test_subject';
    v_mes_head VARCHAR2(300) := 'Вітаю ! </br> Ось звіт з нашою компанії: </br></br>';
    v_mes_text VARCHAR2(3000);

BEGIN
    v_emp_id := p_emp_id;
    select em.email
    into v_recipient
    from dima.employees em
    where em.employee_id = v_emp_id; 

    v_recipient := v_recipient||'@gmail.com';

    select em.first_name||' '||em.last_name as name
    into v_emp_name
    from dima.employees em
    where em.employee_id = v_emp_id; 

    v_mes_head := 'Здравсвуйте, '||v_emp_name|| '! Отчет по домашнему заданию 5_3</br></br>';

SELECT
    '<!DOCTYPE html>
    <html>
    <head>
    <title></title>
    <style>
    table, th, td {border: 1px solid;}
    .center{text-align: center;}
    </style>
    </head>
    <body>
    <table border=1 cellspacing=0 cellpadding=2 rules=GROUPS frame=HSIDES>
    <thead>
    <tr align=left>
    <th>департамент id</th>
    <th>кол-во сотрудников</th>
    </tr>
    </thead>
    <tbody>
    '|| list_html || '
    </tbody>
    </table>
    </body>
    </html>' AS html_table
INTO v_mes_text
FROM (
    SELECT LISTAGG('<tr align=left>
    <td>' || department_id || '</td>' || '
    <td class=''center''> ' || emp_count||'</td>
    </tr>', '<tr>')
    WITHIN GROUP(ORDER BY emp_count) AS list_html
    FROM ( select em.department_id, count(*)as emp_count
            from dima.employees em
            group by em.department_id  ) );

    v_mes_text := v_mes_head||'</br></br> ' ||v_mes_text || '</br></br> З повагою, Dima';
    sys.sendmail(   p_recipient => v_recipient,
                    p_subject => v_subject,
                    p_message => v_mes_text || ' ');

  po_result := 'Отчет отправлен на почту сотруднику id='|| v_emp_id || '  '||v_emp_name;
END send_email_rep;
/

-------------------------------

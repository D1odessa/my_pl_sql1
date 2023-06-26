CREATE FUNCTION get_sum_price_sales(p_table VARCHAR2 DEFAULT 'products') RETURN NUMBER IS
   
    v_table VARCHAR2(50) := p_table;
    v_dynamic_sql_code VARCHAR2(500);
    v_sum NUMBER;
    err_tab_ncor EXCEPTION;
    v_message dima.logs.message%TYPE;
    
BEGIN

    IF v_table not in ('products_old','products') THEN
        raise err_tab_ncor;
    END IF;

    v_dynamic_sql_code := 'SELECT SUM(p.price_sales) FROM hr.'||v_table||' p';
    EXECUTE IMMEDIATE v_dynamic_sql_code INTO v_sum;
    
    RETURN v_sum;
    
EXCEPTION
    WHEN err_tab_ncor THEN
        v_message := '"Неприпустиме значення! Очікується products або products_old" (код помилки -20001)' ||SQLERRM ;
        to_log(p_appl_proc => 'util.get_sum_price_sales', p_message => v_message);
        raise_application_error(-20001, 'Неприпустиме значення! Очікується products або products_old" (код помилки -20001)');

END get_sum_price_sales;
/


------TEST ---------

SELECT util.get_sum_price_sales
FROM dual ;

select *
from logs lg;
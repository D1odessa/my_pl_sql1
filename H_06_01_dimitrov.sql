--SET DEFINE OFF; 

SELECT SYS.GET_NBU('https://bank.gov.ua/NBU_uonia?id_api=UONIA_UnsecLoansDepo&json') AS jn_nbu
FROM dual;

------

CREATE TABLE interbank_index_ua_history (   dt DATE,
                                            id_api VARCHAR2(50),
                                            value NUMBER,
                                            special VARCHAR2(30));              
-------

CREATE VIEW interbank_index_ua_v AS 

SELECT to_date(tt.dt,'dd.mm.yyyy')as dt, tt.id_api, tt.value, tt.special
FROM (select sys.get_nbu(p_url => 'https://bank.gov.ua/NBU_uonia?id_api=UONIA_UnsecLoansDepo&json') as res
        from dual)  t
CROSS JOIN json_table
        (
        res,'$[*]'
        COLUMNS (   dt VARCHAR2(50) PATH '$.dt'
                    ,id_api VARCHAR2(50) PATH '$.id_api'
                    ,value NUMBER PATH '$.value'
                    ,special VARCHAR2(30) PATH '$.special'
                )
        ) tt;
        
        
------------

CREATE PROCEDURE download_ibank_index_ua IS

BEGIN
    INSERT INTO interbank_index_ua_history (dt,id_api,value,special)
       SELECT * FROM interbank_index_ua_v jv;
        
END download_ibank_index_ua;
/

------- test procedure
BEGIN  download_ibank_index_ua; END;
/

-----------------
BEGIN
    sys.dbms_scheduler.create_job(  job_name => 'pl_sql_H_06_dimi',
                                    job_type => 'PLSQL_BLOCK',
                                    job_action => 'BEGIN  download_ibank_index_ua; END;',
                                    start_date => SYSDATE,
                                    repeat_interval => 'FREQ=DAILY;BYHOUR=09;BYMINUTE=00',
                                    --repeat_interval => 'FREQ=SECONDLY; INTERVAL=30',
                                    end_date => TO_DATE(NULL),
                                    job_class => 'DEFAULT_JOB_CLASS',
                                    enabled => TRUE,
                                    auto_drop => FALSE,
                                    comments => 'оновлювати кожний день в БД, Український індекс міжбанківських ставок овернайт');
END;
/

--test
BEGIN
    dbms_scheduler.run_job(job_name => 'pl_sql_H_06_dimi');
END;
/
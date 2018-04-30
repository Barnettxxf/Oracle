-- DBMS_JOB

DROP SEQUENCE job_seq;

DROP TABLE job_data PURGE;

DROP PROCEDURE insert_demo_proc;

CREATE SEQUENCE job_seq;

CREATE TABLE job_data(
        jid         NUMBER,
        title       VARCHAR2(20),
        job_date    DATE,
        CONSTRAINT pk_jid PRIMARY KEY(jid)
)

CREATE OR REPLACE PROCEDURE insert_demo_proc(p_title job_data.title%TYPE) AS
BEGIN
    INSERT INTO job_data(jid, title, job_date) VALUES(job_seq.nextval, p_title, SYSDATE);
END;
/

DECLARE
    v_jobno         NUMBER;
BEGIN
    DBMS_JOB.submit(v_jobno,                        -- 通过OUT获取作业号
                    'insert_demo_proc(''作业A'');',      -- 执行作业调用过程
                    SYSDATE,                        -- 作业开始日期
                    'SYSDATE+(1/(24*60*60))'         -- 作业间隔
                    );
    COMMIT;
END;
/

EXCE DBMS_JOB.interval(3, 'SYSDATE+(3/(24*60))')




EXEC DBMS_JOB.remove(2);        -- 删除job
EXEC DBMS_JOB.remove(3);
EXEC DBMS_JOB.remove(4);
EXEC DBMS_JOB.remove(5);
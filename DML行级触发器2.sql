DROP SEQUENCE dept_log_seq;
DROP TABLE dept_log PURGE;
CREATE SEQUENCE dept_log_seq;
CREATE TABLE dept_log(
    logid       NUMBER,
    type        VARCHAR2(20),
    logdate     DATE,
    deptno      VARCHAR2(20),
    dname       VARCHAR2(20),
    loc         VARCHAR2(20)
);

-- 触发器谓词
CREATE OR REPLACE TRIGGER dept_update_trigger
BEFORE INSERT OR UPDATE OR DELETE
ON dept
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO dept_log(logid, type, logdate, deptno, dname, loc)
            VALUES(dept_log_seq.NEXTVAL, 'INSERT', SYSDATE, :new.deptno, :new.dname, :new.loc);
    ELSIF UPDATING THEN
        INSERT INTO dept_log(logid, type, logdate, deptno, dname, loc)
            VALUES(dept_log_seq.NEXTVAL, 'UPDATE', SYSDATE, :new.deptno, :new.dname, :new.loc);
    ELSE
        INSERT INTO dept_log(logid, type, logdate, deptno, dname, loc)
            VALUES(dept_log_seq.NEXTVAL, 'DELETE', SYSDATE, :old.deptno, :old.dname, :new.loc);
    END IF ;
END;
/


-- 定义触发器顺序
CREATE OR REPLACE TRIGGER emp_insert_one
BEFORE INSERT
ON emp
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.put_line('执行EMP_INSERT_ONE');
END;
/

CREATE OR REPLACE TRIGGER emp_insert_two
BEFORE INSERT
ON emp
FOR EACH ROW -- 定义触发器顺序
FOLLOWS emp_insert_one
BEGIN
    DBMS_OUTPUT.put_line('执行EMP_INSERT_TWO');
END;
/

CREATE OR REPLACE TRIGGER emp_insert_three
BEFORE INSERT
ON emp
FOR EACH ROW
FOLLOWS emp_insert_two -- 定义触发器顺序
BEGIN
    DBMS_OUTPUT.put_line('执行EMP_INSERT_THREE');
END;
/
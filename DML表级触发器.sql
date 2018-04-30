-- 在每月的10号才允许办理入职或离职手续
CREATE OR REPLACE TRIGGER forbid_emp_trigger
BEFORE INSERT OR DELETE
ON emp
DECLARE
    v_currentdate       VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(SYSDATE, 'dd') INTO v_currentdate FROM dual;
    IF TRIM(v_currentdate) != '10' THEN
            RAISE_APPLICATION_ERROR(-20000, '在每月的10号才允许办理入职或离职手续');
    END IF;
END;
/


-- 示例，没有满足条件插入
INSERT INTO emp(empno, ename, job, hiredate, sal, comm , mgr, deptno)
    VALUES(8898, 'MLDN', 'MANAGER', SYSDATE, 2000, 500, 7369, 40);
/

-- 在周末和周一不允许更新emp表 | 在下班期间不允许更新emp表
CREATE OR REPLACE TRIGGER forbid_emp_trigger
BEFORE INSERT OR DELETE
ON emp
DECLARE
    v_currentweek       VARCHAR2(20);
    v_currenthour       VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(SYSDATE, 'day'), TO_CHAR(SYSDATE, 'hh24') INTO v_currentweek, v_currenthour FROM dual;
    IF TRIM(v_currentweek) != '星期一' OR TRIM(v_currentweek) != '星期六' OR TRIM(v_currentweek) != '星期日' THEN
            RAISE_APPLICATION_ERROR(-20000, '在周末和周一不允许更新emp表');
    ELSIF TRIM(v_currenthour) > '9' OR TRIM(v_currenthour) < '18' THEN
            RAISE_APPLICATION_ERROR(-20000, '在下班期间不允许更新emp表');
    END IF;
END;
/


-- 在12点之后不允许更新emp表
CREATE OR REPLACE TRIGGER forbid_emp_trigger
BEFORE INSERT OR DELETE
ON emp
DECLARE
    v_currenthour       VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(SYSDATE, 'hh24') INTO v_currenthour FROM dual;
    IF TRIM(v_currenthour) > '12' THEN
            RAISE_APPLICATION_ERROR(-20000, '在12点之后不允许更新emp表');
    END IF;
END;
/


DROP TABLE emp_tax PURGE;
CREATE TABLE emp_tax(
    empno       NUMBER(4),
    ename       VARCHAR2(10),
    sal         NUMBER(7, 2),
    comm         NUMBER(7, 2),
    tax         NUMBER(7, 2),
    CONSTRAINT pk_empno PRIMARY KEY(empno),
    CONSTRAINT fk_empno FOREIGN KEY(empno) REFERENCES emp(empno) ON DELETE CASCADE
);



CREATE OR REPLACE TRIGGER forbid_emp_trigger
AFTER UPDATE OR INSERT OF ename, sal, comm
ON emp
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;  -- 添加自治事务（必须，不然不能提交结果）
    CURSOR cur_emp IS SELECT * FROM emp;    -- 创建游标，获取每行记录
    v_empRow        emp%ROWTYPE;        -- 保存每行记录
    v_salary        emp.sal%TYPE;       -- 保存工资
    v_empTax        emp_tax.tax%TYPE;   -- 保存税点
BEGIN
    DELETE FROM emp_tax ;
    FOR v_empRow IN cur_emp LOOP
        v_salary :=v_empRow.sal + NVL(v_empRow.comm, 0);
        IF v_salary < 2000 THEN
            v_empTax := v_salary * 0.03 ;
        ELSIF v_salary BETWEEN 2000 AND 5000 THEN
            v_empTax := v_salary * 0.08;
        ELSE
            v_empTax := v_salary * 0.10;
        END IF;
        INSERT INTO emp_tax(empno, ename, sal, comm, tax) VALUES
            (v_empRow.empno, v_empRow.ename, v_empRow.sal, v_empRow.comm, v_empTax);
    END LOOP;
    COMMIT;
END;
/
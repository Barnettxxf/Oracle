CREATE OR REPLACE TRIGGER compound_trigger
FOR INSERT OR UPDATE OR DELETE ON dept
COMPOUND TRIGGER
    BEFORE STATEMENT IS
    BEGIN
        DBMS_OUTPUT.put_line('BEFORE STATEMENT');
    END BEFORE STATEMENT;

    BEFORE EACH ROW IS
    BEGIN
        DBMS_OUTPUT.put_line('BEFORE EACH ROW ');
    END BEFORE EACH ROW;

    AFTER EACH ROW IS
    BEGIN
        DBMS_OUTPUT.put_line('AFTER EACH ROW ');
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        DBMS_OUTPUT.put_line('AFTER STATEMENT');
    END AFTER STATEMENT;
END;
/

DELETE TABLE dept WHERE deptno=99;
INSERT INTO dept(deptno, dname, loc) VALUES(99, 'JAVA', 'BEIJING');
COMMIT;



CREATE OR REPLACE TRIGGER compound_trigger
FOR INSERT OR UPDATE OR DELETE ON emp
COMPOUND TRIGGER
    BEFORE STATEMENT IS
        v_currentweek   VARCHAR2(20);
    BEGIN
        SELECT TO_CHAR(SYSDATE, 'day') INTO v_currentweek FROM dual;
        IF TRIM(v_currentweek) IN ('星期六', '星期日') THEN
            RAISE_APPLICATION_ERROR(-20008, '在周末不允许更新emp数据表');
        END IF;
    END BEFORE STATEMENT;

    BEFORE EACH ROW IS
        v_avgSal        NUMBER;
    BEGIN
        IF INSERTING THEN
            :new.ename := UPPER(:new.ename);
            :new.job := UPPER(:new.job);
        END IF;
        IF INSERTING THEN
            SELECT AVG(sal) INTO v_avgSal FROM emp ;
            IF :new.sal > v_avgSal THEN
                RAISE_APPLICATION_ERROR(-20009, '新进员工工资不得高于平均工资');
            END IF;
        END IF;
    END BEFORE EACH ROW;
END;
/
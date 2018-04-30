-- 创建视图
CREATE OR REPLACE VIEW v_myview AS
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno=d.deptno AND d.deptno=20;


INSERT INTO v_myview (empno, ename, job, sal, deptno, dname, loc)
    VALUES (6688, 'mole', 'CLERK', 2000, 50, '教学部', '北京');


CREATE OR REPLACE TRIGGER view_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE ON v_myview
FOR EACH ROW
DECLARE
    v_empCount  NUMBER;
    v_deptCount NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(empno) FROM emp WHERE empno=:new.empno;
        SELECT COUNT(deptno) FROM emp WHERE deptno=:new.deptno;
        IF v_deptCount =0 THEN
            INSERT INTO dept(deptno, dname, loc) VALUES (:new.deptno, :new.dname, :new.loc);
        END IF;
        IF v_empCount =0 THEN
            INSERT INTO emp(empno, ename, sal, deptno) VALUES (:new.empno, :new.ename, :new.sal, :new.deptno);
        END IF;
    ELSIF UPDATING THEN
        UPDATE emp SET ename=:new.empno, job=:new.job, sal=:new.sal WHERE empNO=:new.empno;
        UPDATE dept SET dname=:new.dname, loc=:new.loc WHERE deptno=:new.deptno;
    ELSIF DELETING THEN
        DELETE FROM emp WHERE empno=:old.empno;
        SELECE COUNT(empno) INTO v_empCount FROM emp WHERE deptno=:old.deptno;
        IF v_empCount = 0 THEN
            DELETE FROM dept WHERE deptno=:old.deptno;
        END IF;
    ELSE
        NULL
    END IF;
END;
/
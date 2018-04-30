CREATE OR REPLACE TRIGGER forbid_emp_trigger
BEFORE INSERT
ON emp
FOR EACH ROW
DECLARE
    v_jobCount      NUMBER ;
BEGIN
    SELECT COUNT(empno) INTO v_jobCount FROM emp
    WHERE :new.job IN (SELECT DISTINCT job FROM emp) ;
    IF v_jobCount = 0 THEN
        RAISE_APPLICATION_ERROR(-20008, '增加雇员职位信息名称错误');
    ELSE
        IF :new.sal > 5000 THEN
            RAISE_APPLICATION_ERROR(-20009, '增加雇员的工资不能超过5000');
        END IF;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER emp_update_trigger
BEFORE UPDATE OF sal
ON emp
FOR EACH ROW
BEGIN
    IF ABS(:new.sal / :old.sal) > 0.1 THEN
        RAISE_APPLICATION_ERROR(-20009, '增加雇员的工资涨幅不能超过10%');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER emp_delete_trigger
BEFORE DELETE
ON emp
FOR EACH ROW
BEGIN
    IF :old.deptno = 10 THEN
        RAISE_APPLICATION_ERROR(-20010, '无法删除10部门的雇员');
    END IF;
END;
/


DROP TABLE member PURGE;
DROP TABLE membertemp PURGE;
CREATE SEQUENCE member_sequence;
CREATE TABLE member(
    mid     NUMBER,
    name    VARCHAR2(20),
    address VARCHAR2(50),
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);

CREATE TABLE membertemp AS SELECT * FROM member WHERE 1=2;

-- 触发器实现自增是需要用临时表上操作,不然会无限递归
CREATE OR REPLACE TRIGGER member_insert_trigger
BEFORE INSERT
ON menbertemp
FOR EACH ROW
BEGIN
    DELETE FROM membertemp;
    INSERT INTO membertemp(mid, name,address) VALUES (member_sequence.NEXTVAL, :new.name, :new.address);
END;
/

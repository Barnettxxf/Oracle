-- MAP 和 ORDER 二选一

CREATE OR REPLACE TYPE emp_object_map AS OBJECT (
    atri_empno      NUMBER(4),
    atri_ename      VARCHAR2(10),
    atri_sal        NUMBER(7,2),
    atri_comm       NUMBER(7,2),
    MAP MEMBER FUNCTION compare RETURN NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY emp_object_map AS
    MAP MEMBER FUNCTION compare RETURN NUMBER AS
    BEGIN
        -- 按照 基本工资+佣金 来排序
        RETURN SELF.atri_sal +　SELF.atri_comm;
    END;
END;
/

CREATE TABLE emp_object_map_tab OF emp_object_map;
INSERT INTO emp_object_map_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7369, 'SMITH', 800, 0);
INSERT INTO emp_object_map_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7902, 'FORD', 3000, 0);
INSERT INTO emp_object_map_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7499, 'ALLEN', 1600, 300);
INSERT INTO emp_object_map_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7521, 'WARD', 1250, 500);
INSERT INTO emp_object_map_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7839, 'KING', 5000, 0);
COMMIT;

-- 对象排序
SELECT VALUE(e) ve, atri_empno, atri_ename, atri_sal, atri_comm
FROM emp_object_map e
ORDER BY ve;


-- ORDER 为两个对象排序
CREATE OR REPLACE TYPE emp_object_order AS OBJECT (
    atri_empno      NUMBER(4),
    atri_ename      VARCHAR2(10),
    atri_sal        NUMBER(7,2),
    atri_comm       NUMBER(7,2),
    MAP MEMBER FUNCTION compare(obj emp_object_order) RETURN NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY emp_object_order AS
    ORDER MEMBER FUNCTION compare RETURN NUMBER AS
    BEGIN
        IF (SELF.atri_sal + SELF.atri_comm) > (obj.atri_sal + obj.atri_comm) THEN
            RETURN -1;
        ELSIF (SELF.atri_sal + SELF.atri_comm) < (obj.atri_sal + obj.atri_comm) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
END;
/

DECLARE
    v_emp1  emp_object_oreder;
    v_emp2  emp_object_oreder;
BEGIN
    v_emp1 := emp_object_order(7499, 'ALLEN', 1600, 300);
    v_emp2 := emp_object_order(7521, 'WARD', 1250, 500);
    IF v_emp1 > vemp2 THEN
        DBMS_OUTPUT.put_line('7499的工资高于7521的工资')
    ELSIF v_emp1 < vemp2 THEN
        DBMS_OUTPUT.put_line('7499的工资小于7521的工资')
    ELSE
        DBMS_OUTPUT.put_line('7499的工资等于7521的工资')
    END IF;
END;
/

CREATE TABLE emp_object_order_tab OF emp_object_map;
INSERT INTO emp_object_order_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7369, 'SMITH', 800, 0);
INSERT INTO emp_object_order_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7902, 'FORD', 3000, 0);
INSERT INTO emp_object_order_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7499, 'ALLEN', 1600, 300);
INSERT INTO emp_object_order_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7521, 'WARD', 1250, 500);
INSERT INTO emp_object_order_tab(atri_empno, atri_ename, atri_sal, atri_comm)
VALUES (7839, 'KING', 5000, 0);
COMMIT;

-- 对象排序
SELECT VALUE(e) ve, atri_empno, atri_ename, atri_sal, atri_comm
FROM emp_object_map e
ORDER BY ve;
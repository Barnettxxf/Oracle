CREATE OR REPLACE TYPE emp_object AS OBJECT (
    atri_empno          NUMBER(4),   -- 雇员编号
    -- 修改当前雇员的工资
    MEMBER PROCEDURE change_emp_sal_proc(p_sql NUMBER),
    -- 取得当前雇员的工资
    MEMBER FUNCTION get_emp_sal_fun RETURN NUMBER,
    -- 修改指定部门之中的所有员工的工资
    STATIC PROCEDURE change_dept_sal_proc(p_deptno NUMBER, p_sal NUMBER),
    -- 取得此部门雇员的工资总和
    STATIC FUNCTION get_dept_sal_sum_fun(p_deptno NUMBER) RETURN NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY emp_object AS
    MEMBER PROCEDURE change_emp_sal_proc(p_sql NUMBER) AS
    BEGIN
        UPDATE emp SET sal=p_sal WHERE empno=SELF.atri_empno;
    END;

    MEMBER FUNCTION get_emp_sal_fun RETURN NUMBER AS
        v_sal       emp.sal%TYPE;
        v_comm      emp.comm%TYPE;
    BEGIN
        SELECT sal, NVL(comm, 0) INTO v_sal, v_comm
        FROM emp
        WHERE empno=SELF.atri_empno;
        RETURN v_sal + v_comm;
    END;

    STATIC PROCEDURE change_dept_sal_proc(p_deptno NUMBER, p_sal NUMBER) AS
    BEGIN
        UPDATE emp SET sal=p_sal WHERE deptno=p_deptno;
    END;

    STATIC FUNCTION get_dept_sal_sum_fun(p_deptno NUMBER) RETURN NUMBER AS
    BEGIN
        SELECT SUM(sal) INTO v_sum FROM emp WHERE deptno=p_deptno;
        RETURN v_sum;
    END;

END;
/

DECLARE
    v_emp   emp_object;
BEGIN
    v_emp := emp_object(7369);
    v_emp.change_emp_sal_proc(3800);
    DBMS_OUTPUT.put_line('7369雇员工资' || v_emp.get_emp_sal_fun());
    DBMS_OUTPUT.put_line('10部门的工资总和' || emp_object.get_dept_sal_sum());
    emp_object.change_dept_sal_proc(10, 7000);
    DBMS_OUTPUT.put_line('10部门的工资总和' || emp_object.get_dept_sal_sum());
END;
/
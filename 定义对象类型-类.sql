CREATE OR REPLACE TYPE emp_object AS OBJECT (
    -- 定义对象属性，与emp表对应
    atri_empno          NUMBER(4),
    atri_sal            NUMBER(7,2),
    atri_deptno         NUMBER(7,2),
    -- 定义对象操作和方法
    MEMBER PROCEDURE change_dept_sal_proc(p_deptno NUMBER, p_precent NUMBER),
    MEMBER FUNCTION get_sal_fun(p_empno NUMBER) RETURN NUMBER,
) NOT FINAL;

CREATE OR REPLACE TYPE BODY emp_object AS
    MEMBER PROCEDURE change_dept_sal_proc(p_deptno NUMBER, p_precent NUMBER) AS
    BEGIN
        UPDATE emp SET sal=sal*(1+p_precent) WHERE deptno=p_deptno;
    END;
    MEMBER FUNCTION get_sal_fun(p_empno NUMBER) RETURN NUMBER AS
    BEGIN
        SELECT sal, NVL(comm, 0) INTO v_sal, v_comm FROM emp WHERE empno=p_empno;
        RETURN v_sal+v_comm;
    END;
END;
/

DECLARE
    v_emp       emp_object;
BEGIN
    -- 示例化对象
    v_emp := emp_object(7369, 800.0, 20);
    -- 修改对象中的数据
    v_emp.arti_sal := 1000;
    DMBS_OUTPUT.put_line('修改候的工资' || v_emp.atri_sal);
END;
/
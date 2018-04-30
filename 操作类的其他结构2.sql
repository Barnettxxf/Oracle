-- 类的构造函数

CREATE OR REPLACE TYPE emp_object AS OBJECT(
    atri_empno      NUMBER(4),
    atri_sal        NUMBER(7,2),
    atri_comm       NUMBER(7,2),
    CONSTRUCTOR FUNCTION emp_object(p_empno NUMBER) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION emp_object(p_empno NUMBER, p_comm NUMBER) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY emp_object AS
    CONSTRUCTOR FUNCTION emp_object(p_empno NUMBER) RETURN SELF AS RESULT AS
    BEGIN
        SELF.atri_empno := p_empno;
        SELECT sal INTO SELF.atri_sal FROM emp WHERE empno=p_empno;
        RETURN;
    END;
    CONSTRUCTOR FUNCTION emp_object(p_empno NUMBER, p_comm NUMBER) RETURN SELF AS RESULT AS
    BEGIN
        SELF.atri_empno := p_empno;
        SELF.atri_comm := p_comm;
        SELF.atri_sal:= 200.0;
        RETURN;
    END;
END;
/

-- 实际上会有三个构造函数
DECLARE
    v_emp1  emp_object;
    v_emp2  emp_object;
    v_emp3  emp_object;
BEGIN
    v_emp1 := emp_object(7369);
    v_emp2 := emp_object(7566, 2400);
    v_emp3 := emp_object(7839, 0, 0); -- 默认构造函数
    DBMS_OUTPUT.put_line(v_emp1.atri_empno || '雇员工资： ' ||　v_emp1.atri_sal);
    DBMS_OUTPUT.put_line(v_emp2.atri_empno || '雇员工资： ' ||　v_emp2.atri_sal);
    DBMS_OUTPUT.put_line(v_emp3.atri_empno || '雇员工资： ' ||　v_emp3.atri_sal);
END;
/


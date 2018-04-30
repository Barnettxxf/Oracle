-- 类的嵌套关系
CREATE OR REPLACE TYPE dept_object AS OBJECT(
    atri_deptno         NUMBER(2),
    atri_dname          VARCHAR2(14),
    atri_loc            VARCHAR2(12),
    MEMBER FUNCTION tostring RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE emp_object AS OBJECT (
    atri_empno          NUMBER(4),
    atri_ename          VARCHAR2(10),
    atri_job            VARCHAR2(9),
    atri_hiredate       DATE,
    atri_sal            NUMBER(7,2),
    atri_comm           NUMBER(7,2),
    atri_dept           dept_object,
    MEMBER FUNCTION tostring RETURN VARCHAR2
) NOT FINAL;

CREATE OR REPLACE TYPE BODY deptno_object AS
    MEMBER FUNCTION tostring RETURN VARCHAR2 AS
    BEGIN
        RETURN '部门编号： ' || SELF.atri_deptno || '，名称: ' || SELF.atri_dname || '，位置： ' || SELF.atri_loc;
    END;
END;
/

CREATE OR REPLACE TYPE BODY emp_object AS
    MEMBER FUNCTION tostring RETURN VARCHAR2 AS
    BEGIN
        RETURN '雇员编号： ' || SELF.atri_empno || '，姓名： ' || SELF.atri_ename || '，职位' || SELF.atri_job ||　'，雇佣日期：' || TO_DATE(SELF.atri_hiredate, 'yyyy-mm-dd');
    END;
END;
/


DECLARE
    v_dept      dept_object;
    v_emp       emp_object;
BEGIN
    v_dept := dept_object(10, 'ACCOUNT', 'NEW YORK');
    v_emp := emp_object(7839, 'PRESIDENT', TO_DATE('1981-11-11', 'yyyy-mm-dd', 5000, null, v_dept));
    DBMS_OUTPUT.put_line(v_emp.tostring());
    DBMS_OUTPUT.put_line(v_emp.atri_dept.tostring());
END;
/

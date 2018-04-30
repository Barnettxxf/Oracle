-- 包规范，含有全局变量
CREATE OR REPLACE PACKAGE mldn_pkg
AS
       v_deptno   dept.deptno%TYPE := 10;
       FUNCTION get_emp_fun(p_eno emp.empno%TYPE) RETURN emp%ROWTYPE;
END;
/

-- 包体，使用全局变量
CREATE OR REPLACE PACKAGE BODY mldn_pkg
AS
       FUNCTION get_emp_fun(p_eno emp.empno%TYPE) RETURN emp%ROWTYPE
       AS
                v_empRow          emp%ROWTYPE;
       BEGIN
                SELECT * INTO v_empRow FROM emp
                WHERE empno=p_eno AND deptno=v_deptno;
                RETURN v_empRow;
       END;
END;
/

-- 修改包的全局变量
BEGIN
       mldn_pkg.v_deptno := 20;
END;
/


-- 调用包，查看结果
DECLARE
       v_empResult       emp%ROWTYPE;
BEGIN
       v_empResult := mldn_pkg.get_emp_fun(7369);
       DBMS_OUTPUT.put_line('雇员名称： ' || v_empResult.ename || '，职位： ' || v_empResult.job || '，部门编号：' || mldn_pkg.v_deptno);
END;
/

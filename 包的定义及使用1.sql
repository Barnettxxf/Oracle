-- 定义包规范
CREATE OR REPLACE PACKAGE mldn_pkg
AS
      FUNCTION get_emp_fun(p_dno dept.deptno%TYPE) RETURN SYS_REFCURSOR;
END;

/

-- 定义包体
CREATE OR REPLACE PACKAGE BODY mldn_pkg
AS
       FUNCTION get_emp_fun(p_dno dept.deptno%TYPE) RETURN SYS_REFCURSOR
       AS
                cur_var           SYS_REFCURSOR;
       BEGIN
                OPEN cur_var FOR SELECT * FROM emp WHERE deptno=p_dno;
                RETURN cur_var;
       END;
END;
/


SELECT * FROM user_objects WHERE object_name = 'MLDN_PKG';
/

SELECT * FROM user_source WHERE type = 'PACKAGE' AND name = 'MLDN_PKG';
/


DECLARE
       v_receive          SYS_REFCURSOR;
       v_empRow           emp%ROWTYPE;
BEGIN
       v_receive := mldn_pkg.get_emp_fun(10); -- 调用包的操作
       LOOP
                          FETCH v_receive INTO v_empRow ;
                          EXIT WHEN v_receive%NOTFOUND ;
                          DBMS_OUTPUT.put_line('雇员姓名： ' || v_empRow.ename || '，雇员职位： ' || v_empRow.job);
       END LOOP ;
END ;
/

-- 删除包
DROP PACKAGE mldn_pkg;
/

--重新编译包
ALTER PACKAGE mldn_pkg COMPILE PACKAGE;
/

-- 包的重载定义
CREATE OR REPLACE PACKAGE emp_delete_pkg
AS
       -- 删除雇员时所发生的异常
       emp_delete_exception EXCEPTION;
       -- 根据雇员编号删除
       PROCEDURE delete_emp_proc(p_empno emp.empno%TYPE);
       -- 根据雇员姓名删除
       PROCEDURE delete_emp_proc(p_ename emp.ename%TYPE);
       -- 根据部门编号和职位删除
       PROCEDURE delete_emp_proc(p_deptno emp.deptno%TYPE, p_job emp.job%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY emp_delete_pkg
AS
       -- 根据雇员编号删除
       PROCEDURE delete_emp_proc(p_empno emp.empno%TYPE)
       AS
       BEGIN
                 DELETE FROM emp WHERE empno=p_empno;
                 IF SQL%NOTFOUND THEN
                                 RAISE emp_delete_exception;
                 END IF;
       END delete_emp_proc;

       -- 根据雇员姓名删除
       PROCEDURE delete_emp_proc(p_ename emp.ename%TYPE)
       AS
       BEGIN
                 DELETE FROM emp WHERE ename=p_ename;
                 IF SQL%NOTFOUND THEN
                                 RAISE emp_delete_exception;
                 END IF;
       END delete_emp_proc;

       -- 根据部门编号和职位删除
       PROCEDURE delete_emp_proc(p_deptno emp.deptno%TYPE, p_job emp.job%TYPE)
       AS
       BEGIN
                 DELETE FROM emp WHERE deptno=p_deptno AND job=p_job;
                 IF SQL%NOTFOUND THEN
                                 RAISE emp_delete_exception;
                 END IF;
       END delete_emp_proc;
END;
/

-- 不存在数据
EXEC emp_delete_pkg.delete_emp_proc(8888);
EXEC emp_delete_pkg.delete_emp_proc(7369);
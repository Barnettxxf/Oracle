DECLARE
   v_emp_empno emp.empno%TYPE,
   TYPE emp_type IS RECORD (
           ename            emp.ename%TYPE,
           job              emp.job%TYPE,
           hiredate         emp.hiredate%TYPE,
           sal              emp.sal%TYPE,
           comm             emp.comm%TYPE
   );
   v_emp        emp_type;
BEGIN
    v_emp_empno := &inputEmpno;
    SELECT ename, job, hiredate, sal, comm INTO v_emp FROM emp WHERE empno=v_emp_empno;
    DBMS_OUTPUT.putline('...');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.putline('...');
END;
/
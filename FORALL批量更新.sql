DECLARE
    TYPE emp_varray IS VARRAY(8) OF emp.empno%TYPE;
    v_empno emp_varray:=emp_varray(7369,7566,7788,7839,7902);
BEGIN
    FOR x IN v_empno.FIRST .. v_empno.LAST LOOP
        UPDATE emp SET sal=9000 WHERE empno=v_empno(x);
    END LOOP;
END;
/

-- 与上面for对比 批量输出操作
DECLARE
    TYPE emp_varray IS VARRAY(8) OF emp.empno%TYPE;
    v_empno emp_varray:=emp_varray(7369,7566,7788,7839,7902);
BEGIN
    FORALL x IN v_empno.FIRST .. v_empno.LAST
        UPDATE emp SET sal=9000 WHERE empno=v_empno(x);
END;
/


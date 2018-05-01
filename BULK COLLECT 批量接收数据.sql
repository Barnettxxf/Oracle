DECLARE
    TYPE ename_varray IS VARRAY(8) OF emp.ename%TYPE;
    v_ename ename_varray;
BEGIN
    SELECT ename BULK COLLECT INTO v_ename
    FROM emp WHERE deptno=10
    FOR x IN ename.FIRST .. ename.LAST LOOP
        DBMS_OUTPUT.put_line('...' || ename(x) );
    END LOOP;
END;
/


DECLARE
    TYPE dept_nested IS TABLE OF dept%ROWTYPE;
    v_dept dept_nested;
BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept
    FOR x IN dept.FIRST .. dept.LAST LOOP   -- x是索引
        DBMS_OUTPUT.put_line('...' || v_dept(x).deptno || '...');
    END LOOP;
END;
/
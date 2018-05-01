SQL%FOUND
SQL%ISOPEN
SQL%NOTFOUND
SQL%ROWCOUNT

DECLARE
    CURSOR cur_emp IS SELECT * FROM emp;
    v_empRow        emp%ROWTYPE;
BEGIN
    -- 检查游标是否打开
    IF cur_emp%ISOPEN THEN
        NULL;
    ELSE
        OPEN cur_emp;
    END IF;
    -- 取得当前行数据
    FETCH cur_emp INTO v_empRow;
    -- 没有数据则推出循环
    WHILE cur_emp%FOUND LOOP
        DBMS_OUTPUT.put_line('...');
        FETCH cur_emp INTO v_empRow; -- 把游标指向下一行
    END LOOP;
    -- 关闭游标
    CLOSE cur_emp;
END;
/

-- 用for循环会更方便
DECLARE
    CURSOR cur_emp IS SELECT * FROM emp;
    v_empRow        emp%ROWTYPE;
BEGIN
    -- 取得当前行数据
    FETCH cur_emp INTO v_empRow;
    -- 没有数据则推出循环
    FOR v_empRow IN cur_emp LOOP
        DBMS_OUTPUT.put_line('...');
        FETCH cur_emp INTO v_empRow; -- 把游标指向下一行
    END LOOP;
    -- 关闭游标
    CLOSE cur_emp;
END;
/


DECLARE
    CURSOR cur_emp IS SELECT * FROM emp;
    TYPE emp_index IS TABLE OF emp%ROWTYPE INDEX BY PLS_INTEGER;
    v_emp emp_index;
BEGIN
    FOR emp_row IN cur_emp LOOP
        v_emp(emp_row.empno) := emp_row;
    END LOOP;
    DBMS_OUTPUT.put_line('...' || v_emp(7369).empno );

END;
/


-- 参数游标
DECLARE
    CURSOR cur_emp(p_dno emp.deptno%TYPE) IS SELECT * FROM emp WHERE deptno=p_dno;
BEGIN
    FOR emp_row IN cur_emp(&inputDeptno) LOOP
        DBMS_OUTPUT.put_line('...'|| emp_row.job);
    END LOOP;
END;
/


-- 定义dept嵌套表
DECLARE
    TYPE dept_nested IS TABLE OF dept%ROWTYPE;
    v_detp dept_nested;
    CURSOR cur_dept IS SELECT * FROM dept;
BEGIN
    -- 检查游标是否打开
    IF cur_emp%ISOPEN THEN
        NULL;
    ELSE
        OPEN cur_emp;
    END IF;

    FETCH cur_dept BULK COLLECT INTO v_dept;
    FOR x IN v_dept.FIRST .. v_dept.LAST LOOP
        DBMS_OUTPUT.put_line('' || v_dept(x) );
    END LOOP;

    CLOSE cur_emp;
END;
/



DECLARE
    TYPE dept_varray IS VARRAY(2) OF dept%ROWTYPE;
    v_detp dept_nested;
    CURSOR cur_dept IS SELECT * FROM dept;
    v_rows NUMBER :=2;
    v_count NUMBER :=1;
BEGIN
    -- 检查游标是否打开
    IF cur_emp%ISOPEN THEN
        NULL;
    ELSE
        OPEN cur_emp;
    END IF;
    CLOSE cur_emp;

    FETCH cur_dept BULK COLLECT INTO v_dept LIMIT v_rows; -- 保存指定行数
    FOR x IN v_dept.FIRST .. (v_dept.LAST - v_count ) LOOP
        DBMS_OUTPUT.put_line('' || v_dept(x).dname );
    END LOOP;


END;
/
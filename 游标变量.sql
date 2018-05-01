DECLARE
    -- 定义强类型游标类型
    TYPE dept_ref IS REF CURSOR RETURN dept%ROWTYPE;
    -- 定义游标边变量
    cur_dept    dept_ref;
    -- 定义行类型
    v_deptRow   dept%ROWTYPE;
BEGIN
    OPEN cur_dept FOR SELECT * FROM dept;
    -- 游标变量只能用loop来循环
    LOOP
        FETCH cur_dept INTO v_deptRow;
        EXIT WHEN cur_dept%NOTFOUND;
        DBMS_OUTPUT.put_line('' || v_deptRow.deptno);
    END LOOP;
    CLOSE cur_dept;
END;
/

DECLARE
    -- 定义弱类型游标类型，自动锁定rowtype
    TYPE dept_ref IS REF CURSOR;
    -- 定义游标边变量
    cur_var    dept_ref;
    -- 定义行类型
    v_deptRow   dept%ROWTYPE;
    v_empRow   dept%ROWTYPE;
BEGIN
    OPEN cur_var FOR SELECT * FROM dept;
    -- 游标变量只能用loop来循环
    LOOP
        FETCH cur_var INTO v_deptRow;
        EXIT WHEN cur_var%NOTFOUND;
        DBMS_OUTPUT.put_line('' || v_deptRow.deptno);
    END LOOP;
    CLOSE cur_var;
    --------------------------------------------------
    OPEN cur_var FOR SELECT * FROM emp WHERE deptno=10;
    -- 游标变量只能用loop来循环
    LOOP
        FETCH cur_var INTO v_empRow;
        EXIT WHEN cur_var%NOTFOUND;
        DBMS_OUTPUT.put_line('' || v_empRow.deptno);
    END LOOP;
    CLOSE cur_var;
EXCEPTION
    WHEN ROWTYPE_MISMATCH THEN
        DBMS_OUTPUT.put_line('游标数据类型不匹配');
END;
/
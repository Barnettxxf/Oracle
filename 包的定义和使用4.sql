-- 不建议在初始化时大量取数据于内存中

CREATE OR REPLACE PACKAGE init_pkg AS
    TYPE dept_index IS TABLE OF dept%ROWTYPE INDEX BY PLS_INTEGER;
    CURSOR dept_cur RETURN dept%ROWTYPE;
    v_dept  dept_index;
    FUNCTION dept_insert_fun(p_deptno dept.deptno%TYPE, p_dname dept.dname%TYPE, p_loc dept.loc%TYPE) RETURN BOOLEAN;
END;
/

CREATE OR REPLACE PACKAGE BODY init_pkg AS
    -- 准备好了强类型游标
    CURSOR dept_cur RETURN dept%ROWTYPE IS SELECT * FROM dept;
    FUNCTION dept_insert_fun(p_deptno dept.deptno%TYPE, p_dname dept.dname%TYPE, p_loc dept.loc%TYPE) RETURN BOOLEAN AS
    BEGIN
        IF NOT v_dept.EXISTS(p_deptno) THEN
            INSERT INTO dept(deptno, dname,loc) VALUES
            (p_deptno, p_dname, p_loc);
            v_dept(p_deptno).deptno := p_deptno;
            v_dept(p_deptno).dname := p_dname;
            v_dept(p_deptno).loc := p_loc;
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    END dept_insert_fun;
BEGIN
    -- 包初始化操作，所有记录保存在索引表
    FOR dept_row IN dept_cur LOOP
        v_dept(dept_row.deptno) := dept_row;
    END LOOP;
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.put_line('程序有错误');
END;
/

BEGIN
     DBMS_OUTPUT.put_line('部门编号： ' || init_pkg.v_dept(10).deptno || '，名称： ' || init_pkg.v_dept(10).dname ||
     '，位置： ' || init_pkg.v_dept(10).loc);
END;
/
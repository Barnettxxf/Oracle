-- 包的纯度

CREATE OR REPLACE PACKAGE purity_pkg AS
    -- 定义包中的变量
    v_name  VARCHAR2(10) := 'mldn';
    -- 根据雇员编号删除数据，但此函数不能执行更新操作
    FUNCTION emp_delete_fun_wnds(p_empno emp.empno%TYPE)  RETURN NUMBER;
    -- 根据雇员编号查找雇员信息， 但是此函数不能执行select操作
    FUNCTION emp_find_fun_rnds(p_empno emp.empno%TYPE) RETURN NUMBER;
    -- 修改包中的变量，但是现在不予许修改
    FUNCTION change_name_fun_wnps(p_param VARCHAR2) RETURN VARCHAR2;
    -- 读取v_name变量内容，但是此函数不能读取包中的变量
    FUNCTION get_name_fun_rnps(p_params VARCHAR2) RETURN VARCHAR2;
    -- 之后还需要设置函数的纯度级别
    PRAGMA RESTRICT_REFERENCES(emp_delete_fun_wnds, WNDS);
    PRAGMA RESTRICT_REFERENCES(emp_find_fun_rnds, RNDS);
    PRAGMA RESTRICT_REFERENCES(change_name_fun_wnps, WNPS);
    PRAGMA RESTRICT_REFERENCES(get_name_fun_rnps, RNPS);
END;
/

-- 故意违反纯度
CREATE OR REPLACE PACKAGE BODY purity_pkg AS
    -- 定义包中的变量
    v_name  VARCHAR2(10) := 'mldn';
    -- 根据雇员编号删除数据，但此函数不能执行更新操作
    FUNCTION emp_delete_fun_wnds(p_empno emp.empno%TYPE)  RETURN NUMBER AS
    BEGIN
        -- WNDS, 无法执行更新操作
        DELETE FROM emp WHERE empno=p_empno;
    END emp_find_fun_rnds;
    -- 根据雇员编号查找雇员信息， 但是此函数不能执行select操作
    FUNCTION emp_find_fun_rnds(p_empno emp.empno%TYPE) RETURN NUMBER AS
    BEGIN
        -- RNDS， 无法执行select操作
        SELECT * INTO v_emp FROM emp WHERE empno=p_empno;
    END emp_find_fun_rnds;
    -- 修改包中的变量，但是现在不予许修改
    FUNCTION change_name_fun_wnps(p_param VARCHAR2) RETURN VARCHAR2 AS
    BEGIN
        -- WNPS, 无法更改包中的变量
        v_name := p_param;
        RETURN '';
    END change_name_fun_wnps;
    -- 读取v_name变量内容，但是此函数不能读取包中的变量
    FUNCTION get_name_fun_rnps(p_params VARCHAR2) RETURN VARCHAR2 AS
    BEGIN
        -- RNPS, 不能读取包中的变量
        RETURN v_name;
    END get_name_fun_rnps;
    -- 之后还需要设置函数的纯度级别
END;
/

-- 定义公共函数
CREATE OR REPLACE PACKAGE purity2_pkg AS
    FUNCTION tax_fun(p_sal emp.sal%TYPE) RETURN NUMBER;
    PRAGMA RESTRICT_REFERENCES(tax_fun, WNDS, WNPS, RNPS);
END;
/

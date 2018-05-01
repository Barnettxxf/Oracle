-- 存在事务隐患
DECLARE 
    CURSOR cur_emp IS SELECT * FROM emp;
BEGIN 
    FOR emp_row IN cur_emp LOOP 
        IF emp_row.deptno = 10 THEN 
            IF emp_row.sal*1.15 < 5000 THEN 
                UPDATE emp SET sal=sal*1.15 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSIF emp_row.deptno = 20 THEN
            IF emp_row.sal*1.22 < 5000 THEN 
                UPDATE emp SET sal=sal*1.22 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSIF emp_row.deptno = 30 THEN
            IF emp_row.sal*1.39 < 5000 THEN 
                UPDATE emp SET sal=sal*1.39 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSE 
            NULL;
        END IF;
    END LOOP;
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.put_line('...' || SQLCODE);
        DBMS_OUTPUT.put_line('...' || SQLERRM);
        ROLLBACE;
END;
/

-- 改进
DECLARE 
    -- 添加for update nowait 子句 ，表被锁定时直接返回对应错误；
    CURSOR cur_emp IS SELECT * FROM emp FOR UPDATE NOWAIT ;
BEGIN 
    FOR emp_row IN cur_emp LOOP 
        IF emp_row.deptno = 10 THEN 
            IF emp_row.sal*1.15 < 5000 THEN 
                UPDATE emp SET sal=sal*1.15 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSIF emp_row.deptno = 20 THEN
            IF emp_row.sal*1.22 < 5000 THEN 
                UPDATE emp SET sal=sal*1.22 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSIF emp_row.deptno = 30 THEN
            IF emp_row.sal*1.39 < 5000 THEN 
                UPDATE emp SET sal=sal*1.39 WHERE empno=emp_row.empno;
            ELSE 
                UPDATE emp SET sal=5000 WHERE empno=emp_row.empno;
            END IF ;
        ELSE 
            NULL;
        END IF;
    END LOOP;
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.put_line('...' || SQLCODE);
        DBMS_OUTPUT.put_line('...' || SQLERRM);
        ROLLBACE;
END;
/

DECLARE 
    -- 添加for update [OF COLUMN]子句(多表查询是一定要指定列) ，当前行被锁定；
    CURSOR cur_emp IS SELECT * FROM emp FOR UPDATE ;
BEGIN 
    FOR emp_row IN cur_emp LOOP 
        IF emp_row.deptno = 10 THEN 
            IF emp_row.sal*1.15 < 5000 THEN 
                -- CURRENT OF cur_emp 表示更新游标当前行的数据
                UPDATE emp SET sal=sal*1.15 WHERE CURRENT OF cur_emp;
            ELSE 
                UPDATE emp SET sal=5000 WHERE CURRENT OF cur_emp;
            END IF ;
        ELSIF emp_row.deptno = 20 THEN
            IF emp_row.sal*1.22 < 5000 THEN 
                UPDATE emp SET sal=sal*1.22 WHERE CURRENT OF cur_emp;
            ELSE 
                UPDATE emp SET sal=5000 WHERE CURRENT OF cur_emp;
            END IF ;
        ELSIF emp_row.deptno = 30 THEN
            IF emp_row.sal*1.39 < 5000 THEN 
                UPDATE emp SET sal=sal*1.39 WHERE CURRENT OF cur_emp;
            ELSE 
                UPDATE emp SET sal=5000 WHERE CURRENT OF cur_emp;
            END IF ;
        ELSE 
            NULL;
        END IF;
    END LOOP;
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.put_line('...' || SQLCODE);
        DBMS_OUTPUT.put_line('...' || SQLERRM);
        ROLLBACE;
END;
/
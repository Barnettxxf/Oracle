-- 没有第一的索引没有值
DECLARE
    TYPE info_index IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    v_info  info_index;
BEGIN
    v_info(1) := 'MLDN';
    v_info(100) := 'MLDN';
    DBMS_OUTPUT.put_line('' || v_info(1));
    DBMS_OUTPUT.put_line('' || v_info(100);
    -- 检查索引10有没有值
    IF v_info.EXISTS(10) THEN
        DBMS_OUTPUT.put_line('' || v_info(10);
    END IF;
END;
/

DECLARE
    TYPE info_index IS TABLE OF VARCHAR2(20) INDEX BY VARCHAR2(20);
    v_info  info_index;
BEGIN
    v_info('MLDN') := 'MLDN';
    v_info('JAVA') := 'JAVA';
    DBMS_OUTPUT.put_line('' || v_info('MLDN');
    DBMS_OUTPUT.put_line('' || v_info('JAVA');
    -- 检查索引10有没有值
    IF v_info.EXISTS('ANDROIN') THEN
        DBMS_OUTPUT.put_line('' || v_info('ANDROIN');
    END IF;
END;
/

DECLARE
    TYPE info_index IS TABLE OF dept%ROWTYPE INDEX BY PLS_INTEGER;
    v_info  info_index;
    v_deptRow  dept%ROWTYPE;
BEGIN
    SELECT * INTO v_deptRow FROM dept WHERE deptno=10;
    v_info(0) := v_deptRow;
    -- 检查索引10有没有值
    IF v_info.EXISTS(0) THEN
        DBMS_OUTPUT.put_line('' || v_info(0).deptno);
    END IF;
END;
/
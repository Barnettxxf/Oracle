BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put('www.');  -- 设置缓冲区的内容
    DBMS_OUTPUT.put('mldn.cn'); -- 同上
    DBMS_OUTPUT.new_line; -- 换行，输出缓冲区的内容
    DBMS_OUTPUT.put('www.mldnjava.cn'); -- 换行，输出缓冲区的内容
    DBMS_OUTPUT.new_line;
    DBMS_OUTPUT.put('bbs.mldn.cn'); -- 没有newline无法输出
END;
/


DECLARE
    v_line1     VARCHAR2(200);
    v_line2     VARCHAR2(200);
    v_line3     VARCHAR2(200);
    v_lines     VARCHAR2(200);
    v_status     NUMBER := 3;
BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.get_line(v_line1, v_status);
    DBMS_OUTPUT.get_line(v_line2, v_status);
    DBMS_OUTPUT.get_line(v_line3, v_status);
    -- DBMS_OUTPUT.get_lines(v_line3, v_status);

    DBMS_OUTPUT.put_line('取得数据' || v_line1);
    DBMS_OUTPUT.put_line('取得数据' || v_line2);
    DBMS_OUTPUT.put_line('取得数据' || v_line3);
END;
/
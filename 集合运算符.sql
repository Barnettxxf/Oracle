-- 长度
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_all list_nested := list_nested('a','a','b','c','c','d','e');
BEGIN
    DBMS_OUTPUT.put_line('集合长度: ' || CARDINALITY(v_all));
    DBMS_OUTPUT.put_line('去重后集合长度: ' || CARDINALITY(SET(v_all)));
END;
/

-- 是否为空
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested();
BEGIN
    IF v_allA IS NOT EMPTY THEN
        DBMS_OUTPUT.put_line('不是空集合' );
    END IF ;
    IF v_allB IS EMPTY THEN
        DBMS_OUTPUT.put_line('是空集合' );
    END IF ;
END;
/

-- 是否含有元素
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_str VARCHAR2(50) := 'a';
BEGIN
    IF v_av_strllA MEMBER OF v_allA THEN
        DBMS_OUTPUT.put_line('含有' );
    END IF ;
END;
/

-- 差集
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested('a','a','b','c','d');
    v_allC list_nested;
BEGIN
    v_allC := v_allA MULTISET EXCEPT v_allB;
    FOR x IN v_allC.FIRST .. v_allC.LAST LOOP
        DBMS_OUTPUT.put_line(v_allC(x));
    END LOOP;
END;
/


-- 交集
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested('a','a','b','c','d');
    v_allC list_nested;
BEGIN
    v_allC := v_allA MULTISET INTERSECT v_allB;
    FOR x IN v_allC.FIRST .. v_allC.LAST LOOP
        DBMS_OUTPUT.put_line(v_allC(x));
    END LOOP;
END;
/

-- 并集
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested('a','a','b','c','d');
    v_allC list_nested;
BEGIN
    v_allC := v_allA MULTISET UNION v_allB;
    FOR x IN v_allC.FIRST .. v_allC.LAST LOOP
        DBMS_OUTPUT.put_line(v_allC(x));
    END LOOP;
END;
/

-- 判断是否是集合
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested('a','a','b','c','d');
    v_allC list_nested;
BEGIN
    IF v_allC IS A SET THEN
        DBMS_OUTPUT.put_line('是一个集合');
    END IF ;
END;
/

-- 子集
DECLARE
    TYPE list_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    v_allA list_nested := list_nested('a','a','b','c','c','d','e');
    v_allB list_nested := list_nested('a','a','b','c','d');
    v_allC list_nested;
BEGIN
    IF v_allB SUBMULTISET v_allA THEN
        DBMS_OUTPUT.put_line('是一个子集合');
    END IF ;
END;
/
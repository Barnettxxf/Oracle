-- PL/SQL 使用

DECLARE
    TYPE project_nested IS TABLE OF VARCHAR2(50) NOT NULL;
    projects_list project_nested:=project_nested('', '', '', '');
BEGIN
    FOR x IN 1 .. projects_list.COUNT LOOP
        DBMS_OUTPUT.put_line('' || projects_list(x));
    END LOOP;
    --------------------------------------------
    FOR x IN projects_list.FIRST .. projects_list.LAST LOOP
        DBMS_OUTPUT.put_line('' || projects_list(x));
    END LOOP;
END;
/
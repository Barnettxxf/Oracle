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


-- 复合类型嵌套表

CREATE OR REPLACE TYPE project_type AS OBJECT (
    projectid           NUMBER,
    projectname         VARCHAR2(50),
    projectfunds        NUMBER,
    pubdate             DATE
);
/

CREATE TABLE department (
    did     NUMBER,
    deptname       VARCHAR2(30) NOT NULL,
    projects       project_type, -- 嵌套表类型
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE AS projects_nested_table;
/

CREATE OR REPLACE TYPE project_nested IS TABLE OF project_type NOT NULL;

DECLARE
    v_dept department%ROWTYPE;
    v_projects project_nested := project_nested(project_type('...'), project_type('...'));
BEGIN
    FOR x  IN v_projects.FIRST .. v_projects.LAST LOOP
        DBMS_OUTPUT.put_line('...');
    END LOOP;
END;
/
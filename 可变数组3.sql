-- project_varray
DECLARE
    TYPE project_varray IS VARRAY(3) OF VARCHAR2(50);
    projects_list project_varray:=project_varray(NULL, NULL, NULL);
BEGIN
    projects_list(1) := '...';
    projects_list(2) := '...';
    projects_list(3) := '...';
    FOR x IN 1 .. projects_list.COUNT LOOP
        DBMS_OUTPUT.put_line('' || projects_list(x));
    END LOOP;
END;
/
-- project_varray复合使用
CREATE OR REPLACE TYPE project_type AS OBJECT (
    projectid           NUMBER,
    projectname         VARCHAR2(50),
    projectfunds        NUMBER,
    pubdate             DATE
);
/

-- 定义含嵌套表的表
CREATE TABLE department (
    did     NUMBER,
    deptname       VARCHAR2(30) NOT NULL,
    projects       project_type, -- 嵌套表类型
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE AS projects_nested_table;
/

CREATE OR REPLACE TYPE project_varray IS VARRAY(3) OF project_type NOT NULL;

DECLARE
    v_dept department%ROWTYPE;
    v_projects project_varray := project_varray(project_type('...'), project_type('...'));
BEGIN
    FOR x  IN v_projects.FIRST .. v_projects.LAST LOOP
        DBMS_OUTPUT.put_line('...');
    END LOOP;
END;
/
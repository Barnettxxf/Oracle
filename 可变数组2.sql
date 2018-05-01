-- 嵌套类型
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

CREATE OR REPLACE TYPE project_varray IS VARRAY(5) OF project_type NOT NULL;

DECLARE
    v_dept department%ROWTYPE;
    v_projects project_varray := project_varray(project_type('...'), project_type('...'));
BEGIN
    FOR x  IN v_projects.FIRST .. v_projects.LAST LOOP
        DBMS_OUTPUT.put_line('...');
    END LOOP;
END;
/
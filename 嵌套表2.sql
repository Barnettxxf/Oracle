-- 创建对象类型
CREATE OR REPLACE TYPE project_type AS OBJECT (
    projectid           NUMBER,
    projectname         VARCHAR2(50),
    projectfunds        NUMBER,
    pubdate             DATE
);
/

-- 使用创建的新对象类型当做嵌套表的数据结构
CREATE OR REPLACE TYPE project_nested IS TABLE OF project_type NOT NULL;

CREATE TABLE department (
    did     NUMBER,
    deptname       VARCHAR2(30) NOT NULL,
    projects       project_type, -- 嵌套表类型
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE AS projects_nested_table;
/

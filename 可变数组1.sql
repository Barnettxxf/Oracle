-- 可变数组是长度固定的嵌套表

CREATE OR REPLACE TYPE project_varray IS VARRAY(3) OF VARCHAR2(50);

-- 建立嵌套表
CREATE TABLE department (
    did     NUMBER,
    deptname       VARCHAR2(30) NOT NULL,
    projects       project_varray, -- 数组类型
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE AS projects_nested_table;
/
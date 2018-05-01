-- 建立嵌套表类型
CREATE OR REPLACE TYPE project_nested IS TABLE OF VARCHAR2(50) NOT NULL;
/

-- 定义数据表，使用嵌套表类型
CREATE TABLE department (
    did     NUMBER,
    deptname       VARCHAR2(30) NOT NULL,
    projects       project_nested, -- 嵌套表类型
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE AS projects_nested_table;
/

-- 查询嵌套表的类型
SELECT * FROM TABLE (SELECT projects FROM department WHERE did=10);
/

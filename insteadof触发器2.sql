-- 定义复合类型
DROP TYPE project_type;
DROP TYPE project_nested;
CREATE OR REPLACE TYPE project_type AS OBJECT(
    projectid       NUMBER,
    projectname     VARCHAR2(50),
    projectfunds    NUMBER,
    pubdate         DATE
);

-- 定义嵌套表类型
CREATE OR REPLACE TYPE project_nested AS TABLE OF project_nested NOT NULL;

-- 创建嵌套表类型数据
DROP TABLE department PURGE;
CREATE TABLE department(
    did         NUMBER,
    deptname    VARCHAR2(50),
    projects    projects_nested,
    CONSTRAINT pk_did PRIMARY KEY(did)
) NESTED TABLE projects STORE  AS projects_nest_table;

-- 增加测试数据
INSERT INTO department(did, deptname, projects) VALUES (10, 'mldn',
    project_nested(
        project_type(1, 'JAVA', 8900, TO_DATE('2004-09-27', 'yyyy-mmm-dd')),
        project_type(2, 'ANDROID', 13900, TO_DATE('2010-07-27', 'yyyy-mmm-dd')),
    ));

INSERT INTO department(did, deptname, projects) VALUES (20, 'mldn123',
    project_nested(
        project_type(10, 'JAVA BOOK', 89, TO_DATE('2004-09-27', 'yyyy-mmm-dd')),
        project_type(11, 'ANDROID BOOK', 139, TO_DATE('2010-07-27', 'yyyy-mmm-dd')),
        project_type(12, 'ANDROID BOOK', 139, TO_DATE('2012-05-23', 'yyyy-mmm-dd')),
    ));
COMMIT;


CREATE OR REPLACE VIEW v_department10 AS
SELECT * FROM deparment
WHERE did=10;

CREATE OR REPLACE TRIGGER nested_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE
ON NESTED TABLE projects OF v_department10
DECLARE
BEGIN
    IF INSERTING THEN
        INSERT INTO TABLE(SELECT projects FROM department
                          WHERE did=:parent.did) VALUES
                          (:new.projectID, :new.projectname,:new.projectfunds, :new.pubdate);
    ELSIF UPDATING THEN
        UPDATE TABLE (SELECT projects FROM department
                      WHERE did=:parent.did) pro
        SET VALUES(pro)=project_type(:new.projectid, :new.projectname, :new.projectfunds, :new.pubdate)
        WHERE pro.projectid=:old.projectid;
    ELSE
        DELETE FROM TABLE(
            SELECT projects FROM department WHERE did=:parent.did) pro
        )
        WHERE pro.projectid = :old.projectid;
    END IF;
END;
/

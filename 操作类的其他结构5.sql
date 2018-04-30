-- 继承性 UNDER 实现
CREATE OR REPLACE TYPE person_object AS OBJECT (
    atri_pid         NUMBER,
    atri_name       VARCHAR2(10),
    atri_sex        VARCHAR2(10),
    MEMBER FUNCTION get_person_info_fun RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE person_object AS OBJECT AS
    MEMBER FUNCTION get_person_info_fun RETURN VARCHAR2 AS
    BEGIN
        RETURN '' ||　SELF.atri_pid || '' || SELF.atri_name || '' || SELF.atri_sex;
    END;
END;
/

CREATE OR REPLACE TYPE emp_object UNDER person_object (
    atri_job        VARCHAR2(9),
    atri_sal        NUMBER(7,2),
    atri_comm       NUMBER(7,2),
    MEMBER FUNCTION get_emp_info_fun RETURN VARCHAR2
) NOT FINAL;

CREATE OR REPLACE TYPE BODY emp_object AS
    MEMBER FUNCTION get_emp_info_fun RETURN VARCHAR2 AS
    BEGIN
        RETURN '人员编号: ' || SELF.atri_pid || '，姓名： ' || SELF.atri_name || '' || SELF.atri_sex || '' || SELF.atri_job || '' || SELF.atri_sex ;
    END;
END;
/



DROP TABLE info PURGE;
CREATE TABLE info(
    id      NUMBER,
    title   VARCHAR2(20),
    CONSTRAINT pk_id PRIMARY KEY (id)
);

INSERT INTO info(id, title) VALUES(1, 'www.mldnjava.cn');



CREATE OR REPLACE TRIGGER info_trigger
BEFORE INSERT OR UPDATE OR DELETE
ON info
FOR EACH ROW
DECLARE
    v_infocount     NUMBER;
BEGIN
    SELECT COUNT(id) INTO v_infocount FROM info;
    DBMS_OUTPUT.put_line(v_infocount);
END;
/


UPDATE info SET id=2;
--ORA-04091: 表 C##SCOTT.INFO 发生了变化, 触发器/函数不能读它
--ORA-06512: 在 "C##SCOTT.INFO_TRIGGER", line 4
--ORA-04088: 触发器 'C##SCOTT.INFO_TRIGGER' 执行过程中出错
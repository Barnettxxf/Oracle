-- ROWNUM只能直接取第一行数据
SELECT * FROM emp WHERE ROWNUM = 1;

SELECT* FROM emp WHERE ROWNUM > 10;

-- 分页控制
DECLARE
    currentPage         NUMBER;
    pageSize            NUMBER;
BEGIN
    currentPage := &curPage;
    pageSize := &pageSize;
    SELECT * FROM (SELECT ROWNUM, e.* FROM emp e) WHERE ROWNUM BETWEEN currentPage+1 AND currentPage+pageSize;
END;
/
-- 取前五行记录
SELECT * FROM emp ORDER BY sal DESC FETCH FIRST 5 ROW ONLY;

-- 取得4~5条记录
SELECT * FROM emp ORDER BY sal DESC OFFSET 3 ROWS NEXT 2 ROW ONLY;



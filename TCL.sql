-- 트랜잭션(Transaction)
-- 데이터베이스에서 하나의 논리적 작업 단위 -> 여러 개의 쿼리가 모여 하나의 작업을 수행하는 것을 말함
-- ACID
-- 세션 / LOCK

SELECT * FROM DEPT_TEMP;

UPDATE DEPT_TEMP
	SET LOC = 'SUWON'
WHERE DEPTNO = 60;    

COMMIT;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC) VALUES(60, 'BACKEND', 'SUWON');

DELETE FROM DEPT_TEMP
WHERE DEPTNO = 60;
COMMIT;
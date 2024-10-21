-- 데이터 정의어(DDL)
-- DDL 명령어는 따로 커밋하지 않아도 즉시 반영되는 특징 (롤백도 안됨)
-- CREATE : 새로운 데이터베이스 개체 생성 (Entity) - 테이블, 뷰, 인덱스
-- ALTER : 기존 데이터베이스 개체 수정
-- DROP : 데이터베이스 개체 삭제
-- TRUNCATE : 테이블의 모든 데이터를 삭제하지만 테이블 구조는 남겨둠
-- Table이란? 기본 데이터 저장 단위 / 접근 가능한 데이터 보유 / 행, 열로 구성
-- 테이블과 테이블의 관계를 표현하는 데 외래키(Foreign Key)를 사용

-- DDL(Data Definition Language) : 데이터베이스에 데이터를 보관하기 위해 제공되는 생성, 변경, 삭제 관련 기능을 수행


-- NUMBER (만 쓰면) -> 최대 크기로 38자리까지의 숫자 지정

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4), -- 숫자형 데이터 타입, 4자리로 선언
	ENAME VARCHAR2(10), -- 가변문자 데이터 타입, 최대 크기는 4000 바이트, 실제 입력된 크기 만큼 차지
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE, -- 날짜와 시간을 지정하는 날짜형 데이터 타입
	SAL NUMBER(7,2), -- 전체 번위가 7자리에 소수점 이하가 2자리 (정수부는 5자리가 됨)
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- 기존 테이블의 열 구조와 데이터를 복사하여 새 테이블 생성하기
CREATE TABLE DEPT_DDL
	AS SELECT * FROM DEPT;
	
SELECT * FROM DEPT_DDL;

CREATE TABLE EMP_ALTER
	AS SELECT * FROM EMP;
	
SELECT * FROM EMP_ALTER;

-- 열 이름을 추가하는 ADD : 기존 테이블에 새로운 컬럼을 추가하는 명령, 컬럼값은 NULL로 입력
ALTER TABLE EMP_ALTER
	ADD HP VARCHAR2(20);


-- 열 이름을 변경하는 RENAME
ALTER TABLE EMP_ALTER
	RENAME COLUMN HP TO TEL;

COMMIT;
-- 열의 자료형을 변경하는 MODIFY
-- 자료형 변경 시 데이터가 이미 존재하는 경우 크기를 크게 하는 경우는 문제가 되지 않으나
-- 크기를 줄이는 경우 저장되어 있는 데이터 크기에 따라 변경되지 않을 수 있음
ALTER TABLE EMP_ALTER 
	MODIFY EMPNO NUMBER(5);

SELECT * FROM EMP_ALTER;

-- 특정 열을 삭제하는 DROP // ROLLBACK 불가
ALTER TABLE EMP_ALTER 
	DROP COLUMN TEL;

ROLLBACK;

-- 테이블 이름을 변경하는 RENAME
RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

-- 테이블의 데이터를 삭제하는 TRUNCATE : 테이블의 모든 데이터 삭제, 테이블 구조에 영향 주지 않음
-- DDL 명령어 이기 때문에 ROLLBACK 불가
-- COMMIT이 안된 상태에서는 ROLLBACK 가능 (DDL 명령어 제외)
DELETE FROM EMP_RENAME; -- DELETE 는 DML 이기 때문에 ROLLBACK 가능

TRUNCATE TABLE EMP_RENAME;

-- 테이블을 삭제하는 DROP
DROP TABLE EMP_RENAME;

	
	
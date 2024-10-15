-- EMP 테이블 정보 확인
-- SELECT와 FROM 절
-- SELECT 문은 데이터 베이스에 보관되어 있는 데이터 조회할 때 사용
-- SELECT 절은 FROM 절에 명시한 테이블에서 조회할 열을 지정할 수 있음
-- SELECT [조회할 열], [조회할 열] FROM 테이블 이름;
SELECT * FROM EMP; -- * 모든 컬럼을 의미, FROM 다음에 오는 것이 테이블 이름, SQL 수행문은 ;(세미클론)으로 끝나야 함

-- 특정 컬럼만 선택해서 조회
SELECT EMPNO, ENAME, DEPTNO FROM EMP;
-- 사원번호와 부서번호만 나오도록 SQL 작성 (EMPNO, DEPNO)
SELECT EMPNO, DEPTNO FROM EMP; 
-- 한눈에 보기 좋게 별칭 부여 하기
SELECT ENAME, SAL, (SAL*12)+COMM FROM EMP;

-- 별칭 부여
SELECT ENAME 이름, SAL AS "급여", COMM AS "성과급", (SAL*12) "연봉"
	FROM EMP; -- 작은 따옴표는 안됨 / 띄어쓰기 안됨 -> 큰 따옴표 안에 공백은 가능
	
-- 중복 제거하는 DISTINCT, 데이터를 조회할 때 중복되는 행이 여러 행이 조회될 떄, 중복된 행을 한 개씩만 선택
SELECT DISTINCT DEPTNO 
FROM EMP
ORDER BY DEPTNO ASC; -- ASCENDING // DESCENDING

-- 컬럼값을 계산하는 산술 연산자(+,-,*,/)
SELECT ENAME, SAL, SAL*12 "연간 급여", (SAL*12)+COMM "총 연봉" 
	FROM EMP;
	
-- 연습문제 : 직책(job)을 중복 제거하고 출력하기
SELECT DISTINCT JOB FROM EMP;

-- WHERE 구문
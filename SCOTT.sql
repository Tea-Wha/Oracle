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

-- WHERE 구문 (조건문)
-- 데이터 조회할 때 사용자가 원하는 조건에 맞는 데이터만 조회할 때 사용
SELECT * FROM EMP -- 먼저 테이블 선택되고, WHERE 절에서 행을 제한하고, 출력할 열을 결정
	WHERE DEPTNO = 20;

-- 사원 번호가 7369번인 사원의 모든 정보 확인
SELECT * FROM EMP 
	WHERE EMPNO = 7369; -- 데이터베이스에서 비교는 = (2개 아님)

-- 급여가 2500 초과인 사원의 사원번호, 이름 직책 급여 출력
-- EMP 테이블에서 급여가 2500 초과인 행을 선택하고 사원번호, 사원이름, 직책, 급여에 대한 컬럼 선택해 출력 
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
WHERE SAL > 2500;

-- WHERE 절에 기본 연산자 사용
-- WHERE 절에 사용하는 비교 연산자 : >, >=, <, <=
SELECT * FROM EMP
WHERE SAL * 12 = 36000;

-- 성과급이 500 초과인 사람의 모든 정보 출력
SELECT * FROM EMP 
WHERE COMM > 500;

-- 입사일이 81년1월1일 이전 사람의 모든 정보 출력
SELECT * FROM EMP 
WHERE HIREDATE	< '1982-01-01';-- 데이터베이스의 문자열 비교시 '' (작은따옴표), DATE 타입은 날짜의 형식에 맞으면 가능

-- 같지 않음을 표현하는 여러가지 방법 : <>, !=, ^=, NOT 컬럼명 =
SELECT * FROM EMP
-- WHERE DEPTNO <> 30;
-- WHERE DEPTNO != 30;
-- WHERE DEPTNO ^= 30;
WHERE NOT DEPTNO = 30;

-- 논리 연산자 : AND, OR, NOT
-- 급여가 3000이상이고 부서가 20번인 사원의 모든 정보 출력
SELECT * FROM EMP 
WHERE SAL >= 3000 AND DEPTNO = 20;

-- 급여가 3000이상이거나 부서가 20번인 사원의 모든 정보 출력
SELECT * FROM EMP 
WHERE SAL >= 3000 OR DEPTNO = 20;

-- 급여가 3000 이상이고, 부서가 20번이고, 입사일이 82년 1월 1일 
SELECT * FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20 AND HIREDATE < '82-01-01';

-- 급여가 3000 이상이고, 부서가 20번이거나, 입사일이 82년 1월1일 이전 사원의 정보 출력
SELECT * FROM EMP 
WHERE SAL >= 3000 AND (DEPTNO = 20 OR HIREDATE <'82-01-01');

-- 급여가 2500 이상이고 직책이 MANAGER인 사원의 모든 정보 출력
SELECT * FROM EMP 
WHERE SAL >= 2500 AND JOB = 'MANAGER';

-- IN 연산자 : 여러개의 열 이름을 조회할 경우 연속해서 나열할 수 있음
SELECT * FROM EMP
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK'

SELECT * FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- IN 연산자를 사용해 20번과 30번 부서에 포함된 사원의 모든 정보 출력
SELECT * FROM EMP
WHERE DEPTNO IN (20,30);

-- NOT IN 연산자를 사용해 20번과 30번 부서에 포함된 사원 조회
SELECT * FROM EMP
WHERE DEPTNO NOT IN(10);

-- 비교 연산자와 AND 연산자를 사용하여 출력하기
SELECT * FROM EMP
WHERE JOB != 'MANAGER' AND JOB <> 'SALESMAN' AND JOB ^= 'CLERK';

-- BETWEEN A AND B 연산자 : 일정한 범위를 조회할 때 사용하는 연산자

-- 급여가 2000에서 3000 사이 사원의 모든 정보 출력
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000; -- BETWEEN / AND

SELECT * FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000; -- 비교 연산자 / AND

-- 사원 번호가 7689 에서 7902 까지의 사원의 모든 정보를 출력하기
SELECT * FROM EMP 
WHERE EMPNO BETWEEN 7689 AND 7902;

-- 1980년이 아닌해에 입사한 사원의 모든 정보 출력
SELECT * FROM EMP
WHERE HIREDATE NOT BETWEEN '1980-01-01' AND '1980-12-31';

SELECT * FROM EMP
WHERE HIREDATE >= '1981-01-01' OR HIREDATE <= '1979-12-31';

-- LIKE, NOT LIKE 연산자 : 문자열을 검색할 때 사용하는 연산자
-- % : 길이와 상관없이 모든 문자 데이터를 의미
-- _ : 문자 1개를 의미
SELECT EMPNO, ENAME FROM EMP
WHERE ENAME LIKE '%K%'; -- 앞과 뒤의 문자열 길이에 상관없이 K라는 문자가 이름에 포함되어 있는 사원 정보 출력
-- %K -> 맨 뒤에가 K 일 때 출력 / K% -> 맨 앞에가 K 일 때

-- 사원의 이름을 두 번째 글자가 L인 사원만 출력하기
SELECT * FROM EMP
WHERE ENAME LIKE '_L%';
-- _L% 맨 앞에서 2번 째 / %L_ 맨 뒤에서 2번 째

-- [실습] 사원 이름에 AM이 포함되어 있는 사원 데이터만 출력
SELECT * FROM EMP
WHERE ENAME LIKE '%AM%';

-- [실습] 사원 이름에 AM이 포함되어 있지 않은 사원 데이터만 출력
SELECT * FROM EMP
WHERE ENAME NOT LIKE '%AM%';

-- 와일드 카드 문자 -> % 가 데이터 일부일 경우 : (%, _) ESCAPE로 지정된 '\' 뒤에 오는 % -> 와일드카드가 아니라는 의미
-- 와일드 카드 문지 = %
SELECT * FROM EMP
WHERE ENAME LIKE '%\%S' ESCAPE '\'; -- 사원 이름이 %S로 끝나는 사원을 조회

-- DML
INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO )
VALUES(1001,'JAME%S', 'MANAGER', 7839, '2014-10-15', 3509, 450, 30)

DELETE FROM EMP
WHERE EMPNO = 1001;

SELECT * FROM EMP;

-- IS NULL 연산자 : 
-- 데이터 값에는 NULL 값을 가질 수 있음, 값이 정해지지 않음을 의미, 연산 불가(계산, 비교, 할당) 
SELECT ENAME, SAL, SAL*12+COMM "연봉", COMM FROM EMP;

-- 비교연산으로 NULL 비교하기 -> NULL은 비교가 안됨 (비교 불가)
SELECT * FROM EMP
WHERE COMM = NULL; -- NULL 비교 불가이므로 결과가 나오지 않음

-- 해당 데이터가 NULL 인지 확인하는 방법은 IS NULL 연산자를 사용해야함
SELECT * FROM EMP
WHERE COMM IS NULL;

-- 해당 데이터가 NULL 이 아닌 데이터만 출력하기
SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- 직속 상관이 있는 사원 데이터 출력하기
SELECT * FROM EMP
WHERE MGR IS NOT NULL;

-- 정렬을 위한 ORDER BY 절 : 오름차순 또는 내림차순 정렬 가능
SELECT * FROM EMP
ORDER BY SAL; -- 급여에 대한 오름 차순 정렬

SELECT * FROM EMP
ORDER BY SAL DESC; -- 급여에 대한 내림 차순 정렬

-- 사원번호 기준 내림차순 정렬하기
SELECT * FROM EMP
ORDER BY EMPNO DESC;

-- 정렬 조건을 여러 컬럼으로 설정하기
SELECT * FROM EMP
ORDER BY SAL DESC, ENAME; -- 급여가 많은 사람 순으로 정렬, 급여가 같으면 이름순 정렬

-- 별칭 사용과 ORDER BY
SELECT EMPNO 사원번호, ENAME 사원명, SAL 월급, HIREDATE 입사일 FROM EMP -- 1. 먼저 테이블을 가져옴 (FROM EMP)
WHERE SAL >= 3000												 -- 2. 해당 조건에 맞는 행(튜플)을 가져옴
ORDER BY 월급 DESC, 사원명 ASC; -- 입력 순 적용 (사원명이 먼저 입력 되었다면 사원 오름차순 먼저 실행) -- 3. SELECT 절 / 4. ORDER 절

-- 연결 연산자 : SELECT 문 조회 시 컬럼 사이에 특정한 문자를 넣을 때 사용
SELECT ENAME || '의 직책은' || JOB "사원 정보" FROM EMP
WHERE JOB = 'CLERK';

-- [실슴문제1] 사원 이름이 S로 끝나는 사원 데이터를 모두 출력
SELECT * FROM EMP
WHERE ENAME LIKE '%S';

-- [실슴문제2] 30번 부서에 근무하고 있는 사원 중, 직책이 SALESMAN 인 사원의 사원번호, 이름, 직책, 급여, 부서번호 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

-- [실습문제3] 20번과 30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원의 사원번호, 이름, 직책, 급여, 부서번호 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
WHERE DEPTNO IN (20,30) AND SAL > 2000;

-- [실습문제4] 급여가 2000 이상 3000 이하 범위 이외의 값을 가진 사원의 모든 정보 출력
SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;

-- [실습문제5] 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름, 번호, 급여, 부서번호 출력 
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP
WHERE ENAME LIKE '%E%' AND DEPTNO = 30 AND SAL NOT BETWEEN 1000 AND 2000;

-- [실습문제6] 추가 수당이 존재하지 않고, 상급자가 존재하고 직책이 MANAGER, CLECK인 사원 중 사원 이름의 두번째 글짜가
-- L이 아닌 사원의 모든 정보 출력하기
SELECT * FROM EMP
WHERE COMM IS NULL AND MGR IS NOT NULL AND JOB IN ('MANAGER','CLERK') AND ENAME NOT LIKE '_L%';
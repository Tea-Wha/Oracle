-- 다중행 함수 : 여러 행에 대해서 함수가 적용되어 하나의 결과르 나타내는 함수
SELECT DEPTNO, SUM(SAL) FROM EMP -- SUM -> 다중행 함수/집계 함수 -> 여러 행의 결과 -> 하나의 행에 출력
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;
-- 부서별 합계 
-- 행의 개수가 맞지 않으면 다중행 함수가 출력되지 않는다.

-- 다중행 함수의 종류 -> 결과는 항상 하나로 출력
-- SUM() : 지정한 데이터의 합을 반환
-- COUNT() : 지정한 데이터의 개수를 반환
-- MAX() : 최대값 반환
-- MIN() : 최소값 반환
-- AVG() : 평균값 반환
-- 집계함수(다중행함수) -> NULL 값이 포함되어 있으면 무시
-- 모두 NULL 값이라면 NULL 반환

SELECT SUM(DISTINCT SAL), SUM(SAL) FROM EMP;

-- 모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT SUM(SAL), SUM(NVL(COMM,0)) AS "SUM(COMM)" FROM EMP;
-- NULL 값이 SUM에는 제한을 주지 않는다?

-- 각 부서의 모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT DEPTNO, SUM(SAL), SUM(NVL(COMM,0)) AS "SUM(COMM)" FROM EMP
GROUP BY DEPTNO;

-- 각 직책별로 급여와 추가 수당의 합을 구하기
SELECT JOB, SUM(SAL), SUM(NVL(COMM,0)) AS "SUM(COMM)" FROM EMP
GROUP BY JOB
ORDER BY SUM(SAL) DESC;

-- 각 부서별 최대 급여를 받는 사원의 급여, 부서 출력하기
SELECT MAX(SAL), DEPTNO FROM EMP
GROUP BY DEPTNO; 

-- GROUP BY 없이 출력하려면?
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30;

-- 부서 번호가 20인 사원중 가장 최근 입사자 출력하기
SELECT MAX(TO_CHAR(HIREDATE,'YYYY-MM-DD')) FROM EMP
WHERE DEPTNO = 20;

-- 서브쿼리 사용하기 : 각 부서별 최대(MAX) 급여 받는 사원의 사원번호, 이름, 직책, 부서번호 출력
SELECT MAX(SAL), DEPTNO FROM EMP
GROUP BY DEPTNO;

SELECT EMPNO, ENAME, JOB, DEPTNO, SAL FROM EMP e
WHERE SAL = ( -- SALL을 정하는데
	SELECT MAX(SAL) -- MAX값을 찾아라
	FROM EMP e2 
	WHERE e2.DEPTNO = e.DEPTNO -- 비교해 가면서 MAX 값을 DEPTNO 에 따라 반환하라 
	)
ORDER BY DEPTNO DESC;

SELECT EMPNO, ENAME,JOB, DEPTNO, SAL FROM EMP e
WHERE SAL = ( -- SALL을 정하는데
	SELECT MAX(SAL) -- MAX값을 찾아라
	FROM EMP e2 
	WHERE e2.JOB = e.JOB -- 비교해 가면서 MAX 값을 DEPTNO 에 따라 반환하라 
	)
ORDER BY JOB;

-- HAVING 절 : 그룹화된 대상에 대한 출력 제한 (일반적으로 GROUP BY 밑에)
-- GROUP BY 존재할 때만 사용할 수 있음
-- WHERE 조건절과 동일하게 동작하지만, 그룹화된 결과 값의 범위를 제한할 때 사용
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
GROUP BY DEPTNO, JOB -- 각 부서별/JOB별 급여 평균
	HAVING AVG(SAL) >= 2000 -- 그룹 범위 내에서 제한 (AVG(SAL)이 어느 정도 이상인 그룹만 출력하겠다)
ORDER BY DEPTNO; 

-- WHERE 절과 HAVING절 함께 사용하기
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
WHERE SAL <= 3000 -- 급여가 3000 이하인 사람들로 제한
GROUP BY DEPTNO, JOB
	HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;	
-- FROM EMP (1) 먼저 테이블 가져옴 / WHERE (2) 급여 기준으로 행을 제한
-- (3) DEPTNO,JOB 그룹화 / (4) AVG(SAL) 범위 제한 / (5) 출력할 열 제한 / (6) 그룹별, 직책별 오름차순 정렬
-- 열 제한은 생각보다 처리 하는 구간이 뒤쪽에 있다고 알아둘 것

-- HAVING 절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인 사원들의
-- 부서 번호, 직책, 부서별 직책의 평균 급여가 출력
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP e 
GROUP BY DEPTNO, JOB 
	HAVING AVG(SAL) >= 500
ORDER BY DEPTNO, JOB;

-- 2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,
-- 단, 평균 급여를 출력할 때는 소수점 제외하고 부서 번호별로 출력
SELECT DEPTNO, ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(DEPTNO) FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB, COUNT(JOB) FROM EMP
GROUP BY JOB
	HAVING COUNT(JOB) >= 3;

-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT EXTRACT(YEAR FROM HIREDATE), DEPTNO, COUNT(DEPTNO) FROM EMP 
GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
ORDER BY EXTRACT(YEAR FROM HIREDATE);

SELECT TO_CHAR(HIREDATE, 'YYYY'), DEPTNO, COUNT(DEPTNO) FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO 
ORDER BY TO_CHAR(HIREDATE, 'YYYY');



-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O,X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X'), COUNT(NVL(COMM,0)) FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

SELECT 
	CASE 
		WHEN COMM IS NULL THEN 'X'
		WHEN COMM > 0 THEN 'O'
		ELSE 'X'
	END AS "추가수당",
	COUNT(*) AS "사원수"
FROM EMP
GROUP BY CASE 
		WHEN COMM IS NULL THEN 'X'
		WHEN COMM > 0 THEN 'O'
		ELSE 'X'
	END;


-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT EXTRACT(YEAR FROM HIREDATE) AS "입사년도", COUNT(EXTRACT(YEAR FROM HIREDATE)) AS "입사원 수", 
MAX(SAL), SUM(SAL), AVG(SAL) FROM EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY EXTRACT(YEAR FROM HIREDATE);

-- 그룹화 관련 기타 함수 : ROLLUP (그룹화 데이터의 합계를 출력할 때 유용)
SELECT NVL(TO_CHAR(DEPTNO), '전체부서') AS "부서번호", NVL(TO_CHAR(JOB), '부서별직책') AS "직책", COUNT(*) AS "사원수", MAX(SAL) AS "최대급여", MIN(SAL) AS "최소급여", ROUND(AVG(SAL)) AS "평균급여" FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB) -- 그룹 기준으로 합계 밑에 출력
ORDER BY "부서번호", "직책";

-- JOIN 열 추가 -> 오른쪽으로 확장
-- UNION 행 추가 -> 밑으로 확장

-- 집합연산자 : 두개 이상의 쿼리 결과를 하나로 결합하는 연산자 (수직적 처리)
-- 여러개의 SELECT 문을 하나로 연결하는 기능
-- 집합 연산자로 결합하는 결과의 컬럼은 데이터 타입이 동일해야 함 (열의 개수도 동일해야 함)
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 20
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 30
ORDER BY DEPTNO;

-- 교집합 : INTERSECT
-- 여러 개의 SQL 문의 결과에 대한 교집합을 반환
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL < 2000;

SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL > 1000 AND SAL < 2000;

-- 차집합 : MINUS, 중복행에 대한 결과를 하나의 결과로 보여줌

















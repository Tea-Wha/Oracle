-- 서브쿼리 : 다른 SQL 쿼리문 내에 포함되는 쿼리문을 말함
-- 주로 데이터를 필터링 하거나 데이터 집계에 사용
-- 서브쿼리는 SELECT, INSERT, UPDATE, DELETE 문에 모두 사용 가능
-- 단일행 서브쿼리(단 하나의 행으로 결과가 반환) 와 다중행 서브 쿼리(여러 행의 결과과 반환) 가 있음

-- 특정한 사원이 소속된 부서의 이름을 가져오기 
SELECT DNAME AS "부서이름" FROM DEPT -- 메인 쿼리
WHERE DEPTNO = (
	SELECT DEPTNO FROM EMP
	WHERE ENAME = 'KING' -- 서브 쿼리 
);

-- 속도 면에서는 JOIN 이 서브쿼리보다 빠르다

-- 등가 조인을 사용해서 출력
SELECT DNAME FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.ENAME = 'KING';

-- 서브쿼리로 'JONES'의 급여보다 높은 급여를 받는 사원 정보 출력
SELECT * FROM EMP
WHERE SAL > (
	SELECT SAL FROM EMP
	WHERE ENAME = 'JONES'  
);

-- 자체 조인(SELF)으로 풀기
SELECT e1.* FROM EMP e1 JOIN EMP e2
ON e1.SAL > e2.SAL 
WHERE e2.ENAME = 'JONES';

-- 서브쿼리는 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호()로 묶어서 표현
-- 특정한 경우를 제외하고는 ORDER BY 절을 사용할 수 없음 (성능 이슈)
-- 서브쿼리의 SELECT 절에 명시한 열은 메인 쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야 함

-- 문제 : EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당 보다 많은 사원 정보 출력
SELECT * FROM EMP
WHERE NVL(COMM,0) > (
	SELECT NVL(COMM,0) FROM EMP
	WHERE ENAME = 'ALLEN'
);

SELECT * FROM EMP;

-- 문제 : JAMES 보다 먼저 입사한 사원들의 정보 출력
SELECT * FROM EMP
WHERE HIREDATE < (
	SELECT HIREDATE FROM EMP
	WHERE ENAME = 'JAMES'
);

-- 문제 : 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보와 소속부서 조회
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, e.DEPTNO, d.DNAME, d.LOC FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 20 AND e.SAL > (SELECT AVG(SAL) FROM EMP);

SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, e.DEPTNO, d.DNAME, d.LOC FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.SAL > AVG(e.SAL); --

-- 실행 결과가 여러개인 다중행 서브쿼리
-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치 데이터가 있다면 TRUE
-- ANY, SOME : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
-- ALL : 메인 쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 TRUE
-- EXISTS : 서브쿼리의 결과가 존재하면(즉, 한개 이상의 행이 결과를 만족하면) TRUE

-- 메인쿼리에 급여가 서브쿼리에서 각 부서의 최대 급여와 같은 사원의 정보 출력
SELECT * FROM EMP
WHERE SAL IN (
	SELECT MAX(SAL) FROM EMP
	GROUP BY DEPTNO
);

SELECT EMPNO, ENAME, SAL FROM EMP 
WHERE SAL > ANY (
		SELECT SAL FROM EMP
		WHERE JOB = 'SALESMAN'
);

SELECT EMPNO, ENAME, SAL, JOB FROM EMP
WHERE SAL = ANY (
		SELECT SAL FROM EMP
		WHERE JOB = 'SALESMAN'
);

-- 30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 출력
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP 
WHERE SAL < ANY (
	SELECT SAL FROM EMP
	WHERE DEPTNO = 30
);

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP 
WHERE SAL < (
	SELECT MIN(SAL) FROM EMP
	WHERE DEPTNO = 30
);

-- ALL 연산자 사용해서 동일 결과 만들기
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE SAL < ALL (
	SELECT SAL FROM EMP
	WHERE DEPTNO = 30
);

-- 직책이 'MANAGER'인 사원 보다 많은 급여 받는 사원의 사원번호, 이름, 급여, 부서 이름 출력하기
SELECT e.EMPNO, e.ENAME, e.SAL, d.DNAME FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO 
WHERE SAL > ALL (
	SELECT SAL FROM EMP
	WHERE JOB = 'MANAGER'
);

-- EXISTS : 서브쿼리의 결과 값이 하나 이상 존재하면 TRUE
SELECT * FROM EMP
WHERE EXISTS (
	SELECT DNAME FROM DEPT
	WHERE DEPTNO = 10 
);

-- 다중열 서브 쿼리 : 서브 쿼리의 결과가 두 개 이상의 컬럼으로 변환되어 메인 쿼리에 전달하는 쿼리
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE (DEPTNO, SAL) IN (
	SELECT DEPTNO, SAL FROM EMP
	WHERE DEPTNO = 30
);

-- 다중열 서브 쿼리의 경우 -> IN, EXISTS 만 사용 가능
SELECT * FROM EMP
WHERE (DEPTNO, SAL) IN (
	SELECT DEPTNO, MAX(SAL) FROM EMP
	GROUP BY DEPTNO
);

-- FROM 절에 사용하는 서브 쿼리 : 인라인뷰라고 하기도 함
-- 테이블 내 데이터 규모가 너무 크거나 현재 작업에 불필요한 열이 너무 많아 일부 행과 열만 사용하고자 할 때 유용
SELECT e10.EMPNO, e10.ENAME, e10.DEPTNO, d.DNAME, d.LOC FROM (
	SELECT * FROM EMP -- 지금은 다 가져왔지만 열 제한 가능  
	WHERE DEPTNO = 10
) e10 JOIN DEPT d -- AS가 안맞는 이유?
ON e10.DEPTNO = d.DEPTNO;

-- 먼저 정렬하고 해당 개수만 가져 오기 : 급여가 많은 5명에 대한 정보 보여줘
SELECT ROWNUM, ENAME, SAL FROM (
	SELECT * FROM EMP
	ORDER BY SAL DESC
)
WHERE ROWNUM <= 5;

-- SELECT 절에 사용하는 서브 쿼리 : 단일행 서브쿼리를 스칼라 서브쿼리라고 함
-- SELECT 절에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해야 함
SELECT EMPNO, ENAME, JOB, SAL, 
	(SELECT GRADE FROM SALGRADE
	WHERE e.SAL BETWEEN LOSAL AND HISAL
	) AS "급여등급", DEPTNO AS "부서번호",(SELECT DNAME FROM DEPT d
									WHERE e.DEPTNO = d.DEPTNO
	) AS "부서이름" FROM EMP e
ORDER BY "급여등급";

-- 조인문으로 변경하기
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, s.GRADE, e.DEPTNO, d.DNAME FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL -- 비등가 
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO -- 등가
ORDER BY s.GRADE;

-- 부서 위치가 NEWYORK인 경우에는 본사, 그 외에는 분점으로 반환하도록 만들기
SELECT EMPNO, ENAME, JOB, SAL,
	CASE 
		WHEN DEPTNO = (
			SELECT DEPTNO FROM DEPT
			WHERE LOC = 'NEW YORK') THEN '본사'
		ELSE '분점'
	END AS "소속" 
FROM EMP
ORDER BY "소속" DESC;
	
-- 연습 문제 1번
-- 전체 사원 중 ALLEN과 같은 직책(JOB) 인 사원들의 사원 정보, 부서 정보를 출력 (직책, 사원번호, 사원이름, 급여, 부서번호, 부서이름)
SELECT e.JOB, e.EMPNO, e.ENAME, e.SAL, e.DEPTNO, d.DNAME FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.JOB IN (
	SELECT JOB FROM EMP
	WHERE ENAME = 'ALLEN'
);

-- 연습 문제 2번
-- 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보 출력
-- (단 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하세요)
-- (사원번호, 이름, 입사일, 급여, 급여 등급, 부서이름, 부서위치)
SELECT e.EMPNO, e.ENAME, TO_CHAR(e.HIREDATE, 'YYYY-MM-DD') "입사날짜", e.SAL, s.GRADE, d.DNAME, d.LOC FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.SAL > (
	SELECT AVG(SAL) FROM EMP
)
ORDER BY e.SAL DESC, e.EMPNO;


-- 연습 문제 3번
-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보 출력
-- (사원번호, 사원이름, 직책, 부서번호, 부서이름, 부서위치)
SELECT e.EMPNO, e.ENAME, e.JOB, e.DEPTNO, d.DNAME, d.LOC FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 10 AND e.JOB NOT IN (
	SELECT JOB FROM EMP
	WHERE DEPTNO = 30
	);

-- 연습 문제 4번
-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보 출력
-- 다중행 함수 사용 X 사원 번호 기준 오름차순 정렬
-- (사원번호, 사원이름, 급여, 급여 등급)
SELECT e.EMPNO, e.ENAME, e.SAL, s.GRADE FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e.SAL > (
	SELECT MAX(SAL) FROM EMP
	WHERE JOB = 'SALESMAN'
)
ORDER BY EMPNO;

SELECT e.EMPNO, e.ENAME, e.SAL, s.GRADE FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e.SAL > ALL (
	SELECT SAL FROM EMP
	WHERE JOB = 'SALESMAN'
)
ORDER BY EMPNO;
	




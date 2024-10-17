-- 조인 : 여러 테이블을 하나의 테이블처럼 사용하는 것
-- 이 때 필요한 것 PK(Primary Key)와 테이블 간 공통 값인 FK(Foreign Key)를 사용
-- JOIN 의 종류 
-- INNER JOIN (동등 조인) : 두 테이블에서 일치하는 데이터만 선택
-- LEFT JOIN : 왼쪽 테이블의 모든 데이터와 일치하는 데이터 선택
-- RIGHT JOIN : 오른쪽 테이블의 모든 데이터와 일치하는 데이터 선택
-- FULL OUTER JOIN : 두 테이블의 모든 데이터를 선택

-- Cartesian 곱 : 두 개의 테이블을 조인할 때 기준 열을 지정하지 않으면, 모든 행 * 모든 행
SELECT * FROM EMP, DEPT
ORDER BY EMPNO; -- 정렬 기준은 앞 테이블의 함수

-- 등가 조인 : 일치하는 열이 존재, INNER 조인이라고 함, 가장 일반적인 조인 방식
-- ORACLE JOIN 방식
SELECT EMPNO, ENAME, JOB, SAL, e.DEPTNO FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY EMPNO;

-- ANSI JOIN 방식
SELECT EMPNO, ENAME, JOB, SAL, e.DEPTNO FROM EMP e JOIN DEPT d 
ON e.DEPTNO =d.DEPTNO 
ORDER BY EMPNO;

-- DEPT 테이블과 EMP 테이블은 1:N 관계를 가짐 (부서 테이블의 부서번호에는 여러명의 사원이 올 수 있다.)

-- JOIN 이서 출력 범위 설정하기
SELECT EMPNO, ENAME, SAL, d.DEPTNO, DNAME, LOC FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE SAL >= 3000;

-- EMP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 등가 조인을 했을 때 급여가 2500 이하이고,
-- 사원 번호가 9999 이하인 사원의 정보를 출려되로록 작성
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC  FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE EMPNO <= 9999 AND E.SAL < 2500
ORDER BY EMPNO;


-- 비등가 조인 : 동일한 컬럼이 존재하지 않는 경우 조인할 때 사용, 일반적인 방식은 아님
SELECT * FROM SALGRADE; -- 각 급여에 대한 등급 표시

SELECT ENAME, SAL, GRADE FROM EMP e JOIN SALGRADE s 
ON SAL BETWEEN s.LOSAL AND s.HISAL -- 급여와 losal ~ hisal 비등가 조인

-- 자체 조인(SELF JOIN) : 자기 자신의 테이블과 조인하는 것을 말함 (같은 테이블을 두번 사용함)
SELECT e1.EMPNO AS "사원번호", e1.ENAME AS "사원이름", e2.EMPNO AS "상관사원번호", 
e2.ENAME AS "상관이름" FROM EMP e1 JOIN EMP e2
ON e1.MGR = e2.EMPNO; -- MGR 과 EMPNO 조인 이 떄 e2에는 상관의 정보가 걸려있음

-- 외부 조인(OUTER JOIN) : LEFT, RIGHT, FULL
SELECT e.ENAME, e.DEPTNO, d.DNAME FROM EMP e FULL OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO -- LEFT OUTER -> 왼쪽 기준
ORDER BY e.DEPTNO;  -- RIGHT OUTER -> 오른쪽 기준 / -- FULL OUTER -> 양쪽 기준

-- NATURAL JOIN : 등가 조인과 비슷하지만 WHERE 조건절 없이 사용 
-- (두 테이블의 동일한 이름이 있는 열을 자동으로 찾아서 조인 해줌)
SELECT EMPNO, ENAME, DEPTNO, DNAME FROM EMP NATURAL JOIN DEPT
ORDER BY DEPTNO;
-- 자동으로 걸어준다면 겹치는 부분은 더 이상 누구의 소유가 아니기에 서브쿼리 지정 불가능

-- JOIN ~ USING : 등가 조인을 대신하는 조인 방식
SELECT e.EMPNO, e.ENAME, e.JOB, DEPTNO, d.DNAME, d.LOC FROM EMP e JOIN DEPT d USING(DEPTNO)
ORDER BY e.EMPNO;

-- Q1. 급여가 2000 초과인 사원들의 정보 출력 (부서 번호, 부서 이름, 사원 번호, 사원 이름, 급여)
SELECT e.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, SAL FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE SAL > 2000
ORDER BY e.DEPTNO; 

-- Q2. 각 부서별 평균 급어, 최대 급여, 최소 급여, 사원수 출력 (부서 번호, 부서 이름 --- )
SELECT e.DEPTNO, d.DNAME, ROUND(AVG(e.SAL)), MAX(e.SAL), MIN(e.SAL), COUNT(e.DEPTNO) FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO, d.DNAME;

-- Q3. 모든 부서 정보와 사원 정보 출력 (부서 번호와 부서 이름 순으로 정렬)
SELECT * FROM EMP e RIGHT OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO 
ORDER BY d.DEPTNO;






-- 함수 : 특정 결과를 얻기 위해 데이터를 입력할 수 있는 특수 명령어를 의미
-- 함수에는 내장 함수와 사용자 정의 함수가 있음
-- 내장 함수에는 단일행 함수와 다중행 함수 (집계 함수) 로 나누어짐
-- 단일행 함수 : 데이터가 한 행씩 입력되고 결과가 한 행씩 나오는 함수
-- 다중행 함수 : 여러 행이 입력되어서 하나의 행으로 결과가 반환되는 것
-- 숫자 함수 : 수학 계산식을 처리하기 위한 함수

SELECT -10, ABS(-10) FROM DUAL; -- DUAL -> 가상의 테이블

-- ROUND(숫자, 반올림할 위치) : 반올림한 결과를 반환하는 함수
SELECT ROUND(1234.5678) AS ROUND, -- 소수점 첫째자리에서 반올림해서 결과를 반환
ROUND(1234.5678, 0) AS ROUND_0,
ROUND(1234.5678, 1) AS ROUND_1,-- 소수점 둘째자리에서 반올림해서 결과를 반환함
ROUND(1234.5678, 2) AS ROUND_2, -- 소수점 셋째자리에서 반올림해서 결과를 반환함
ROUND(1234.5678, -1) AS ROUND_MINUS1, -- 정수 첫번째 자리를 반올림 
ROUND(1234.5678, -2) AS ROUND_MINUS2 -- 정수 두번째 자리에서 반올림
FROM DUAL;

-- TRUNC : 버림을 한 결과를 반환하는 함수, 자릿수 지정 가능
SELECT TRUNC(1234.5678) "TRUNC",
TRUNC(1234.5678, 0) "TRUNC_0",
TRUNC(1234.5678, 1) "TRUNC_1",
TRUNC(1234.5678, 2) "TRUNC_2",
TRUNC(1234.5678, -1) "TRUNC_MINUS1",
TRUNC(1234.5678, -2) "TRUNC_MINUS2"
FROM DUAL;

-- MOD : 나누기한 후 나머지를 출력하는 함수
SELECT MOD(21, 5) FROM DUAL;

-- CEIL : 소수점 이하를 올림
SELECT CEIL(12.345) FROM DUAL;

-- FLOOR : 소수점 이하를 날림
SELECT FLOOR(12.999) FROM DUAL;

-- POWER : 제곱하는 함수
SELECT POWER(3, 4) FROM DUAL; -- 3 * 3 * 3 * 3

-- DUAL : SYS 계정에서 제공하는 테이블, 테이블 참조 없이 실행해보기 위해 FROM 절에 사용하는 더미 테이블
SELECT 20*30 AS MULTIPLY FROM DUAL;

-- 문자 함수 : 문자 데이터로부터 특정 결과를 얻고자 할 때 사용하는 함수
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;

-- UPPER 함수로 문자열 비교하기
SELECT * FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%james%'); -- 타입이 일정하지 않을 때 Upper 함수로 강제로 동일하게 만들 수 있음(활용)

-- 문자열 길이를 구하는 LENGTH 함수, LENGTHB 함수
-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트를 반환
SELECT LENGTH(ENAME), LENGTHB(ENAME) FROM EMP; -- 영어는 한바이트를 차지하기 때문에 길이와 바이트수가 동일

SELECT LENGTH('하니'), LENGTHB('하니') FROM DUAL; -- 오라클 XE 에서 한글은 3바이트 차지

-- 직책이름의 길이가 6글자 이상이고, COMM 있는 사원의 모든 정보 출력
SELECT * FROM EMP
WHERE LENGTH(JOB) >= 6 AND COMM IS NOT NULL AND COMM != 0;

-- SUBSTR / SUBSTRB : 시작 위치로부터 선택 개수만큼의 문자를 반환하는 함수 / 파이썬 -> 슬라이싱 / 인덱스는 1부터 시작
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5) FROM EMP;

-- SUBSTR 함수와 다른 함수 함께 사용
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB, -LENGTH(JOB),2), SUBSTR(JOB, -3) FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE', 'L') AS INSTR_1, -- 'L' 문자의 위치 (처음 나오는 지점) 
INSTR('HELLO, ORACLE', 'L',5) AS INSTR_2, -- 5번째 위치에서 시작해서 'L' 문자의 위치 찾기
INSTR('HELLO, ORACLE', 'L',2,2) AS INSTR_3 -- 2번째 위치에서 시작해서 2번째 나타나는 문자의 위치 찾기
FROM DUAL;

-- 특정 문자가 포함된 행 찾기
SELECT * FROM EMP
WHERE INSTR(ENAME, 'S') > 0; -- 'S'문자가 포함된 행 출력 / 값이 없는 경우에는 0 반환(?)

SELECT * FROM EMP
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체할 때 사용
-- 대체할 문자를 지정하지 않으면 삭제
SELECT '010-5006-4146' AS "변경 이전", 
REPLACE('010-5006-4146', '-',' ') AS "변경 이후 1",
REPLACE('010-5006-4146', '-') AS "변경 이후 2"
FROM DUAL;

-- LPAD / RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+') FROM DUAL;

SELECT RPAD('ORACLE', 10, '+') FROM DUAL;

SELECT RPAD('010222-', 14, '*') AS RPAD_JUMIN,
RPAD('010-5006-',13,'*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME), CONCAT(EMPNO, CONCAT(' : ', ENAME)) FROM EMP
WHERE ENAME = 'JAMES';


-- TRIM / LTRIM / RTRIM : 문자열 데이터에서 특정 문자를 지우기 위해 사용, 문자를 지정하지 않으면 공백 제거
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM,
'[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
'[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM
FROM DUAL;

-- 날짜 데이터를 다루는 함수
-- 날짜 데이터 + 숫자 : 가능, 날짜에서 숫자 만큼의 이후 날짜
-- 날짜 데이터 - 숫자 : 가능, 날짜에서 숫자 만큼의 이전 날짜
-- 날짜 데이터 - 날짜 데이터 : 가능, 두 날짜간의 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 연산 불가
-- SYSDATE : 운영체제로부터 시간을 가져오는 함수
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE AS "현재시간",
SYSDATE -1 AS "어제",
SYSDATE +1 AS "내일"
FROM DUAL;

-- 몇 개월 이후 날짜를 구하는 ADD_MONTH 함수 : 특정 날짜에 지정한 개월 수 이후 날짜 데이터 반환
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) AS "3개월 후" FROM DUAL;

-- 입사 10주년이 되는 사원들의 데이터 출력하기 (입사일로부터 10년이 경과한 날짜 데이터 반환)
SELECT EMPNO, ENAME, HIREDATE AS "입사일", ADD_MONTHS(HIREDATE, 12*10) AS "10주년"  FROM EMP;

-- 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE, MONTHS_BETWEEN(HIREDATE, SYSDATE) AS "재직 기간",
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS "재직 기간1", 
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "재직 기간2"
FROM EMP;

-- 돌아오는 요일(NEXT_DAY), 달의 마지막 날짜(LAST_DAY)
SELECT SYSDATE,
NEXT_DAY(SYSDATE, '월요일'),
LAST_DAY(SYSDATE)
FROM DUAL;

SELECT LAST_DAY('24/8/28') FROM DUAL;

-- 날짜 정보 추출 함수 : EXTRACT
SELECT EXTRACT (YEAR FROM DATE '2024-10-16') FROM DUAL;

SELECT * FROM EMP
WHERE EXTRACT (MONTH FROM HIREDATE) = 12;

-- 자료형을 변환하는 형 변환 함수
SELECT EMPNO, ENAME, EMPNO + '500' FROM EMP -- 숫자 문자열 -> 숫자로 변환  
WHERE ENAME = 'FORD'; -- 오라클의 기본 형변환 -> 변경가능하면  숫자로 변환

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수 : 자바의 SimpleDateFormat 유사
SELECT SYSDATE AS "기본시간형태", TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') 
AS "현재날짜" FROM DUAL;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'DD') AS DD,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DY_KOR,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JPN,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DY_ENG,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DAY_KOR,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JPN,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DAY_ENG
FROM DUAL;

-- 숫자 데이터 형식을 지정하여 출력하기
SELECT SAL, 
TO_CHAR(SAL, '$999,999') AS SAL_$, -- 9 는 숫자의 한자리를 의미하고 빈 자리를 채우지 않음
TO_CHAR(SAL, 'L999,999') AS SAL_L, -- 지역 화폐 단위 출력
TO_CHAR(SAL, '999,999.00') AS SAL_1, --0은 빈자리를 0으로 채움
TO_CHAR(SAL, '000,999,999,00') AS SAL_2 
FROM EMP;

-- TO_NUMBER : 숫자 타입의 문자열을 숫자 데이터로 변환한해주는 함수
SELECT 1300 - '1500', '1300' + '1500' FROM DUAL;

-- TO_DATE : 문자열로 명시된 날짜로 변환하는 함수
SELECT TO_DATE('24-10-24', 'YY/MM/DD') AS "날짜 타입",
TO_DATE('20240714', 'YYYY/MM/DD') AS "날짜 타입2"
FROM DUAL;

-- 1981년 7월 1일 이후 입사한 사원 정보 출력하기
SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD');

SELECT * FROM EMP
WHERE HIREDATE > '1981-07-01';

SELECT * FROM EMP
WHERE HIREDATE > '1981/07/01';

SELECT * FROM EMP
WHERE HIREDATE > '19810701';

-- NULL 처리 함수 : 특정 열의 행에 데이터가 없는 경우 데이터값이 NULL이 됨 (NULL 값이 없음)
-- NULL : 값이 할당되지 않았기 때문에 공백이나 0과는 다른 의미, 연산(계산, 비교 등등)
-- NVL(검사할 데이터 또는 열, 앞의 데이터가 NULL인 경우 대체할 값)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, NVL(COMM, 0), SAL*12+NVL(COMM, 0) FROM EMP; 

-- NVL2(검사할 데이터 또는 열, 데이터 NULL이 아닐 때 반환 되는 값, 데이터 NULL일 때 반환되는 값)
SELECT EMPNO, ENAME, COMM, NVL2(COMM, 'O','X'), NVL2(COMM, SAL*12+COMM, SAL*12) AS "연봉" FROM EMP; 

-- NULLIF : 두 값을 비교하여 동일하면 NULL, 동일하지 않으면 첫번째 값을 반환
SELECT NULLIF (10, 10), NULLIF ('A', 'B') FROM DUAL;

-- DECODE : 주어진 데이터 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값 출력
SELECT EMPNO, ENAME, JOB, SAL, DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS "연봉인상" FROM EMP;

-- CASE : SQL의 표준 함수, 일반적으로 SELECT절에서 많이 사용됨
SELECT EMPNO, ENAME, JOB, SAL, CASE JOB 
									WHEN 'MANAGER' THEN SAL * 1.1 
									WHEN 'SALESMAN' THEN SAL * 1.05 
									WHEN 'ANALYST' THEN SAL 
									ELSE SAL * 1.03 
								END AS "연봉인상" 
							FROM EMP;
						
-- 열 값에 따라서 출력이 달라지는 CASE 문 : 기준 데이터를 지정하지 않고 사용하는 방법
SELECT EMPNO, ENAME, COMM,
CASE 
	WHEN COMM IS NULL THEN '해당 사항 없음'
	WHEN COMM = 0 THEN '수당 없음'
	WHEN COMM > 0 THEN '수당 : ' || COMM
END AS "수당 정보"
FROM EMP;

-- 1. EMP 테이블에서 사번, 사원명, 급여 조회 (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, TRUNC(SAL,-2) FROM EMP
ORDER BY SAL DESC;

-- 2. EMP 테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM EMP
WHERE EXTRACT (MONTH FROM(HIREDATE)) = 9;

-- 3. EMP 테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE, 
TO_CHAR(ADD_MONTHS(HIREDATE, 12*40),'YYYY-MM-DD') AS "40주년" FROM EMP;

-- 4. EMP 테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT * FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 38*12; 

-- 실습 문제 : 노션에 DATABASE -> 함수 파트 아래에 있음

SELECT * FROM EMP;

-- 1.
SELECT EMPNO, RPAD(SUBSTR(EMPNO, 1,2),4,'*') AS MASKING_EMPNO, 
ENAME, RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_NAME FROM EMP  
WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;

-- 2.
SELECT EMPNO, ENAME, SAL, TRUNC(SAL/21.5, 2) AS DAY_PAY, ROUND(SAL/21.5/8, 1) AS TIME_PAY FROM EMP;

-- 3.
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE, 
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
NVL2(COMM, TO_CHAR(COMM) , 'N/A') AS COMM FROM EMP;

-- 4.
SELECT EMPNO, ENAME, MGR, CASE WHEN MGR IS NULL THEN '0000'
							   WHEN SUBSTR(MGR,1,2) = 75 THEN '5555'
							   WHEN SUBSTR(MGR,1,2) = 76 THEN '6666'
							   WHEN SUBSTR(MGR,1,2) = 77 THEN '7777'
							   WHEN SUBSTR(MGR,1,2) = 78 THEN '8888'
							   ELSE TO_CHAR(MGR)
							   END AS CHG_MGR
						  FROM EMP;
























































































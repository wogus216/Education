-- 실행은 컨트롤+엔터
-- * : 모든 것
-- 사원명, 업무, 급여만 출력

SELECT ENAME,JOB,SAL
FROM EMP
WHERE SAL >= 1000
;

SELECT *
FROM EMP;

-- EMP에서 급여가 1500이하인 사원의
-- 이름과 입사일, 급여를 나타내시오.

SELECT ENAME,HIREDATE,SAL
FROM EMP
WHERE SAL <= 1500;

--자바랑 다르게 AND ,OR이라고 씀.
-- AND, OR한번에 쓸때는 조건을 괄호로 묶어서 보는 게 좋음.
-- 데이터베이스는 형변환 신경쓸 필요 없음(자동형변환)
--like '문자열' <<찾는 것.

--1. 첫글자가 A 인 문자열 
--'A%'
--2. 마지막 글자가 A인 문자열
--'%A'
--3. A를 포함한 문자열
--'%A%'
--4. A로 시작하는 n글자 문자열
--ex ) 2글자
--'A_'
--ex ) 3글자
--'A__'


SELECT ENAME, SAL
FROM EMP
WHERE ENAME = 'KING';

--첫글자가 A이고  그후에 A가 추가로 1개이상 포함된 사원을 구하시오.

SELECT ENAME
FROM EMP
WHERE  ENAME LIKE 'A%A%';

--급여가 1000이상 1500이하인 사원을 구하시오.
SELECT ENAME
FROM EMP
WHERE SAL>1000 AND SAL<=1500;

--A이상 B이하
SELECT ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1000 AND 1500;

--급여가 1500이거나 3000이거나 5000인 사원을 구하시오.
--값 IN(값1,값2,...)
--값이 값1 또는 값2 또는... 인것
SELECT *
FROM EMP
WHERE SAL IN (1500, 3000, 5000);

SELECT *
FROM EMP
WHERE  SAL= 1500 OR SAL= 3000 OR SAL = 5000;

--급여가 1500이거나 3000이거나 5000이 아닌 사원을 구하시오.

SELECT *
FROM EMP
WHERE SAL NOT IN (1500, 3000, 5000);

--ORDER BY정렬
--직업명 오름차순 이름 내림차순
SELECT *
FROM EMP
ORDER BY JOB ASC, ENAME DESC;


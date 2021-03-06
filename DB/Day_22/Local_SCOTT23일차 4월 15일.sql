--24일차 4월15일 
--주 뷰 조건은 WHERE로 오른쪽 보조뷰 조건은 ON 밑에 달자


SELECT ENAME, JOB, SAL
FROM EMP
UNION
SELECT ENAME AS 이름, JOB, SAL
FROM EMP
;


SELECT ENAME AS 이름, JOB, SAL
FROM EMP
UNION ALL
SELECT ENAME, JOB, SAL
FROM EMP
;

--연도별 입사자 수, 월별 입사자 수 데이터
SELECT TO_CHAR(HIREDATE, 'YY') AS D, COUNT(*) AS CNT, 'Y' AS GBN
FROM EMP 
GROUP BY TO_CHAR(HIREDATE, 'YY'), 'Y'

UNION
SELECT TO_CHAR(HIREDATE, 'MM') AS D, COUNT(*) AS CNT, 'M' AS GBN
FROM EMP 
GROUP BY TO_CHAR(HIREDATE, 'MM'),'M'
;

SELECT  MGR
FROM EMP
WHERE JOB = 'SALESMAN'
;

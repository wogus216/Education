--21일차 4월 13일
--급여등급이 2등급인 사원들 중 부서별 급여 1위를 구하시오
--구하려는 것 : 부서별 급여 1위인 사원
--조건 : 급여등급 2등급
SELECT E.ENAME, E.DNAME, E.SAL, E.GRADE
FROM
        (
        SELECT E.ENAME, D.DNAME, E.SAL, SG.GRADE,
        RANK() OVER(PARTITION BY D.DEPTNO ORDER BY SAL DESC) AS RNK
        FROM EMP E INNER JOIN DEPT D 
            ON E.DEPTNO = D.DEPTNO
            INNER JOIN SALGRADE SG
            ON E. SAL BETWEEN SG.LOSAL AND SG.HISAL
            AND SG.GRADE =2) E
WHERE E.RNK = 1
;
--NULL은 세지 않는다.
--ROW의 수를 다센다.
SELECT  COUNT(ENAME)
FROM EMP

;

-- 수치로 가능한 것만 가져올 수 있음
SELECT SUM(SAL)
FROM EMP
;

SELECT AVG(SAL)
FROM EMP
;

SELECT MAX(SAL)
FROM EMP
;

SELECT MIN(SAL)
FROM EMP
;

--GROUB BY
--부서별,업무별 급여 평균을 구하시오.
SELECT DEPTNO,JOB,AVG(SAL),COUNT(*)

FROM EMP
--WHERE JOB = 'CLERK'
GROUP BY DEPTNO, JOB
ORDER BY AVG(SAL) ASC
;

--직원 수 가 3명이상인 업무별 직원 수를 구하시오.
SELECT  JOB,CNT
FROM      
        (
        SELECT JOB,COUNT(*) AS CNT
        FROM EMP
        GROUP BY JOB
        )
WHERE CNT > =3    
;

SELECT JOB,COUNT(*) AS CNT
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3  
;

마지막 문제
--전체 급여 평균(AVG)이하로 급여를 받는 사원들의 급여를  30%인상하여
--인상된 급여기준으로(파티션) 전체 급여 순위를 구하시오. 급여 1.3
--깨달아야 하는데...참 하낟도 안떠오른다는 말이야 ㅋㅋ
SELECT AVG(SAL)
FROM EMP
;
SELECT E.ENAME, SAL,
    CASE WHEN SAL <= ASAL
            THEN SAL * 1.3
            ELSE SAL
            END AS ESAL
FROM EMP E INNER JOIN (SELECT AVG(SAL) AS ASAL
                        FROM EMP)
                     ON 1=1

;
--내 답
--전체 급여 평균(AVG)이하로 급여를 받는 사원들의 급여를  30%인상하여
--인상된 급여기준으로(파티션) 전체 급여 순위를 구하시오. 급여 1.3
--깨달아야 하는데...참 하낟도 안떠오른다는 말이야 ㅋㅋ   

SELECT AVG(SAL)
FROM EMP
;
SELECT    E.ENAME,E.SAL, E.ESAL,
        RANK() OVER( ORDER BY ESAL DESC) AS RNK
FROM        (  SELECT E.ENAME,E.SAL,
                CASE WHEN E.SAL < A.ASAL
                    THEN E.SAL * 1.3
                    ELSE E.SAL
                END  AS ESAL
                    FROM EMP E INNER JOIN ( SELECT FLOOR(AVG(SAL)) AS ASAL
                                    FROM EMP) A
                                    ON 1=1 ) E
;


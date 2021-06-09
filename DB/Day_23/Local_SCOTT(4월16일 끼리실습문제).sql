--4월 16일 우리끼리 실습 문제 
-- SCOTT 문제 공공1
-- SALES 부서에 있는 사람 중 이름에 'A'가 들어가고, 급여등급이 2등급인 사람을 구하시오.

SELECT *
FROM EMP E INNER JOIN DEPT D 
                        ON 1=1
                    AND E.ENAME LIKE '%A%'
                    AND D.DNAME = 'SALES' 
;

SELECT *
FROM SALGRADE SG INNER JOIN (SELECT *
                            FROM EMP E INNER JOIN DEPT D 
                                          ON 1=1
                                         AND E.ENAME LIKE '%A%'
                                         AND D.DNAME = 'SALES' ) D2
                    ON D2.SAL BETWEEN SG.LOSAL AND SG.HISAL
                    AND SG.GRADE = 2
;

--[SCOTT] 서비스2
-- 'KING'을 제외하고 상반기에 입사한 급여 1,2위 합과 하반기에 입사한 급여 1,2위 합을 구하여 그 차이를 구하시오.

--KING 제외
SELECT ENAME,SAL,HIREDATE, RANK() OVER (ORDER BY SAL DESC) AS RNK
FROM EMP
WHERE ENAME NOT IN 'KING' 
;

--하반기 입사자
SELECT (MAX(E2.SAL) + MIN(E2.SAL)) AS JSUM
FROM(
        SELECT RANK() OVER (ORDER BY E.SAL DESC) AS JRNK,E.SAL
        
        FROM        (SELECT ENAME,SAL,HIREDATE, RANK() OVER (ORDER BY SAL DESC) AS RNK
                        FROM EMP
                        WHERE ENAME NOT IN 'KING' ) E
        WHERE TO_CHAR(HIREDATE, 'MM') > 06 ) E2
WHERE E2.JRNK IN (1,2)
;
--상반기 입사자
SELECT (MAX(F2.SAL) + MIN(F2.SAL)) AS FSUM
FROM(
        SELECT RANK() OVER (ORDER BY E.SAL DESC) AS FRNK,E.SAL
        
        FROM        (SELECT ENAME,SAL,HIREDATE, RANK() OVER (ORDER BY SAL DESC) AS RNK
                        FROM EMP
                        WHERE ENAME NOT IN 'KING' ) E
        WHERE TO_CHAR(HIREDATE, 'MM') <= 06 ) F2
WHERE F2.FRNK IN (1,2)
;

--답

SELECT ABS(JSUM-FSUM) AS RESULT
FROM  (SELECT (MAX(E2.SAL) + MIN(E2.SAL)) AS JSUM
            FROM( SELECT RANK() OVER (ORDER BY E.SAL DESC) AS JRNK,E.SAL
                FROM (SELECT ENAME,SAL,HIREDATE, RANK() OVER (ORDER BY SAL DESC) AS RNK
                        FROM EMP
                WHERE ENAME NOT IN 'KING' ) E
            WHERE TO_CHAR(HIREDATE, 'MM') > 06 ) E2
        WHERE E2.JRNK IN (1,2)) J INNER JOIN (SELECT (MAX(F2.SAL) + MIN(F2.SAL)) AS FSUM
                                                FROM(SELECT RANK() OVER (ORDER BY E.SAL DESC) AS FRNK,E.SAL
                                                    FROM (SELECT ENAME,SAL,HIREDATE, RANK() OVER (ORDER BY SAL DESC) AS RNK
                                                         FROM EMP
                                                        WHERE ENAME NOT IN 'KING' ) E
                                                 WHERE TO_CHAR(HIREDATE, 'MM') <= 06 ) F2
                                               WHERE F2.FRNK IN (1,2) ) F
                                    ON 1=1
;
--(1번) SCOTT 문제 금융
-- 사원번호가 7499인 사원의 직업과 같은 사람의 평균 급여를 출력하시오.
--7499 직업
SELECT JOB
FROM EMP                
WHERE EMPNO = '7499'
;
--7499 사원과 같은 직업 평균 급여

SELECT AVG(SAL)
FROM EMP E INNER JOIN ( SELECT JOB
                        FROM EMP                
                        WHERE EMPNO = '7499') E2
                        ON E.JOB = E2.JOB
;


--공공2
--입사자가 가장 많은 월의 평균 급여를 구하고  전체 평균보다 크면 입사자가 가장 많은 월의 사원들만 20% 삭감, 작을 시 20% 인상하여 
--전체 사원명, 사원급여를 출력하시오.

-- 입사자가 많은 월이 12월
 
 SELECT ROUND(AVG(SAL),2) AS AVG_SAL,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
        FROM EMP
        GROUP BY TO_CHAR(HIREDATE, 'MM')
;

SELECT E.ENAME,
            (CASE WHEN MA.AVG_SAL > A.AVG_SAL
                THEN E.SAL * 0.8
                WHEN MA.AVG_SAL < A.AVG_SAL
                THEN E.SAL * 1.2
                ELSE E.SAL
                END) AS RSAL,E.SAL
FROM EMP E INNER JOIN ( SELECT ROUND(AVG(SAL),2) AS AVG_SAL,
                          RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                         FROM EMP
                     GROUP BY TO_CHAR(HIREDATE, 'MM')) MA
                     ON MA.RNK =1
            INNER JOIN (SELECT ROUND(AVG(SAL),2) AS AVG_SAL
                        FROM EMP) A
                        ON 1=1

;
--서비스1
-- 이름에서 S자가 들어가는 사원이 사는 지역과 등급을 구하시오.
-- 출력 : 이름, 직업, 지역, 등급

SELECT E.ENAME,E.JOB,E.SAL, SG.GRADE, D.LOC
FROM EMP E INNER JOIN SALGRADE SG
                        ON E.SAL BETWEEN LOSAL AND HISAL                  
           INNER JOIN DEPT D
                        ON E.DEPTNO = D.DEPTNO
WHERE ENAME LIKE '%S%'
;


--[SCOTT] 서비스2
-- 'KING'을 제외하고 상반기에 입사한 급여 1,2위 합과 하반기에 입사한 급여 1,2위 합을 구하여 그 차이를 구하시오.
SELECT ABS(SUM( CASE WHEN E.GBN = 0
                    THEN E.SAL
                    ELSE NULL
                    END) - SUM( CASE WHEN E.GBN  =1
                                    THEN E.SAL 
                                    ELSE NULL
                                    END )) AS RESULT
FROM
        (SELECT FLOOR(TO_CHAR(HIREDATE, 'MM') / 7) AS GBN,SAL,HIREDATE,
                RANK() OVER(PARTITION BY FLOOR(TO_CHAR(HIREDATE, 'MM') / 7)
                    ORDER BY SAL DESC ) AS RNK
        FROM EMP
        WHERE ENAME != 'KING') E
WHERE E.RNK IN (1,2)    
;
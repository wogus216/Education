--난이도 하
--급여등급이 2등급인 사원이 가장 많은 부서의 정보를 출력하시오.

SELECT E.DEPTNO
FROM
        (SELECT E.DEPTNO, COUNT(*),
            RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
         FROM EMP E INNER JOIN SALGRADE S 
                            ON SAL BETWEEN LOSAL AND HISAL
                            AND S.GRADE = 2
         GROUP BY E.DEPTNO) E
WHERE E.RNK = 1
;
--급여 등급이 2,4등급인 사원들이 /가장 많이 포함된 부서의 업무별 급여 총 순위를 출력/하시오.
--2,4 등급 많이 포함된 부서
SELECT E.DEPTNO,COUNT(*),
        RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE S 
                        ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE =2 OR S.GRADE = 4
GROUP BY E.DEPTNO
;

SELECT E2.ENAME,E2.JOB,E2.DEPTNO,E2.SAL,
    RANK() OVER(PARTITION BY E2.JOB ORDER BY E2.SAL DESC) AS RSAL
FROM EMP E2 INNER JOIN (SELECT E.DEPTNO,COUNT(*),
                RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
             FROM EMP E INNER JOIN SALGRADE S 
                        ON E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE =2 OR S.GRADE = 4
             GROUP BY E.DEPTNO) D
             ON E2.DEPTNO = D.DEPTNO
WHERE D.RNK =1
;

--KING을 제외한 사원들의 급여 최대치와 최소치를 구하고 그차이를 구하여 전체 급여 평균과의 차이를 구하시오.

SELECT ROUND((MAX(E.SAL)-MIN(E.SAL)) - AVG(E2.SAL)) AS RSAL
FROM  EMP E INNER JOIN  EMP E2
                    ON E.SAL = E2.SAL
WHERE E.ENAME NOT IN 'KING'
;

--난이도 중
--업무가 CLERK인 사원들의 상급자의 급여순위를 포함한 정보를 출력하시오.

SELECT E.MGR,E2.*,
    RANK() OVER(ORDER BY E2.SAL DESC) AS RNK
FROM EMP E INNER JOIN EMP E2 
                ON E.SAL= E2.SAL
WHERE E.JOB IN('CLERK')
;
--이름에 'L'이 들어가는 사원이 가장 많은 업무를 구하고, 그 업무가 가장 많은 부서의 정보를 출력하시오.

SELECT JOB,COUNT(*),
    RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMP
WHERE ENAME LIKE  '%L%'
GROUP BY JOB
;

SELECT *
FROM EMP E INNER JOIN (SELECT JOB,COUNT(*),
                RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
            FROM EMP
            WHERE ENAME LIKE  '%L%'
            GROUP BY JOB) E2
        ON E.JOB = E2.JOB
WHERE E2.RNK = 1
;

SELECT D.*
FROM DEPT D INNER JOIN (SELECT *
                        FROM EMP E INNER JOIN (SELECT JOB,COUNT(*),
                                                    RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                                               FROM EMP
                                               WHERE ENAME LIKE  '%L%'
                                    GROUP BY JOB) E2
                            ON E.JOB = E2.JOB
                        WHERE E2.RNK = 1) E3
                    ON D.DEPTNO = E3.DEPTNO
WHERE E3.RNK = 1
;
--12월 입사자 급여 순위 2등의 급여보다 많은 급여를 받는 사원들 중 가장 많은 사원이 있는 업무를 구하시오.

SELECT ENAME,SAL,
    RANK() OVER (ORDER BY SAL DESC) AS RSAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 12
;

SELECT SAL AS CSAL
FROM (SELECT ENAME,SAL,
            RANK() OVER (ORDER BY SAL DESC) AS RSAL
      FROM EMP
      WHERE TO_CHAR(HIREDATE, 'MM') = 12)
WHERE RSAL = 2
;

SELECT E.ENAME,E.JOB, E.SAL,
    CASE WHEN E.SAL > D.CSAL
        THEN E.SAL
        ELSE NULL
        END AS RRSAL
FROM EMP E INNER JOIN(SELECT SAL AS CSAL
                        FROM (SELECT ENAME,SAL,
                                RANK() OVER (ORDER BY SAL DESC) AS RSAL
                              FROM EMP
                              WHERE TO_CHAR(HIREDATE, 'MM') = 12)
                    WHERE RSAL = 2) D
            ON 1= 1
;
SELECT *
FROM
        (SELECT  D2.JOB,COUNT(*),
            RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
            FROM (SELECT E.ENAME,E.JOB, E.SAL,
                      CASE WHEN E.SAL > D.CSAL
                           THEN E.SAL
                           ELSE NULL
                           END AS RRSAL
               FROM EMP E INNER JOIN(SELECT SAL AS CSAL
                                     FROM (SELECT ENAME,SAL,
                                               RANK() OVER (ORDER BY SAL DESC) AS RSAL
                                           FROM EMP
                                           WHERE TO_CHAR(HIREDATE, 'MM') = 12)
                            WHERE RSAL = 2) D
                    ON 1= 1) D2
        GROUP BY D2.JOB) D3
WHERE RNK =1
;
--난이도 상
--입사자가 가장 많이 입사한 연도의 입사자 평균 급여를 구하고 / 전체사원을 대상으로 구한 평균 급여보다 많이 받는 사람의 급여를 50%삭감하여 
--전체 사원의 정보를 출력하시오.

SELECT TO_CHAR(HIREDATE, 'YY') ,COUNT(*),
    RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YY') 
;
SELECT Y.RYY
FROM  (SELECT TO_CHAR(HIREDATE, 'YY') AS RYY ,COUNT(*),
          RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
       FROM EMP
       GROUP BY TO_CHAR(HIREDATE, 'YY') ) Y
WHERE Y.RNK = 1
;
--81년 평균 급엽
SELECT AVG(E.SAL) AS RAVG
FROM EMP E INNER JOIN (SELECT Y.RYY
                            FROM  (SELECT TO_CHAR(HIREDATE, 'YY') AS RYY ,COUNT(*),
                                        RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
                        FROM EMP
                       GROUP BY TO_CHAR(HIREDATE, 'YY') ) Y
            WHERE Y.RNK = 1) Y2
                ON 1=1
            AND TO_CHAR(HIREDATE, 'YY') = Y2.RYY
;
--입사자가 가장 많이 입사한 연도의 입사자 평균 급여를 구하고 / 전체사원을 대상으로 구한 평균 급여보다 많이 받는 사람의 급여를 50%삭감하여 
--전체 사원의 정보를 출력하시오.

SELECT E2.*,
    CASE WHEN E2.SAL > Y3.RAVG
         THEN E2.SAL * 0.5
         ELSE E2.SAL
         END RSAL
FROM EMP E2 INNER JOIN (SELECT AVG(E.SAL) AS RAVG
                            FROM EMP E INNER JOIN (SELECT Y.RYY
                                                    FROM  (SELECT TO_CHAR(HIREDATE, 'YY') AS RYY ,COUNT(*),
                                                                RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
                                                            FROM EMP
                                                GROUP BY TO_CHAR(HIREDATE, 'YY') ) Y
                                        WHERE Y.RNK = 1) Y2
                                ON 1=1
                        AND TO_CHAR(HIREDATE, 'YY') = Y2.RYY) Y3
                ON 1=1
;


--부서별 급여 평균을 구하고 각각 부서의 사원들의 급여가 각각 부서별 급여평균보다 높으면 급여를 20% 삭감하여
--사원명,사원급여,부서명,부서평균급여을 출력하시오.

SELECT E.DEPTNO,AVG(SAL) AS DSAL,D.DNAME
FROM EMP E INNER JOIN DEPT D 
                    ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO,D.DNAME
;

SELECT E.ENAME,E.SAL,D2.DNAME,D2.DSAL,
    CASE WHEN E.SAL > D2.DSAL
         THEN E.SAL * 0.8
         ELSE E.SAL
         END AS RSAL
FROM EMP E INNER JOIN (SELECT E.DEPTNO,AVG(SAL) AS DSAL,D.DNAME
                            FROM EMP E INNER JOIN DEPT D 
                        ON E.DEPTNO = D.DEPTNO
                        GROUP BY E.DEPTNO,D.DNAME) D2
            ON E.DEPTNO = D2.DEPTNO
;

-- NEW YORK에 업무하는 사원들의 전체 급여 평균과 그 사원들을 제외한 사원들의 급여 평균을 구하여 두 차이를 구하고
-- 구한 차이 이상의 급여를 받는 사원들의 급여를 구한차이만큼 감봉하여 전체 사원의 정보를 출력하시오.

--급여 순위 중 홀 수 번째에 해당하는 사원들의 급여을 10% 감봉하여 전체 사원의 평균을 구하고 구한 평균 이상인 사람들의
--급여를 20%감봉하여 전체 급여순위와 사원정보를 출력하시오.
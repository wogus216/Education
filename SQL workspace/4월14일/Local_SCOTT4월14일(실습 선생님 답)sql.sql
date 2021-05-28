--실습 선생님 답 버전

---하1 급여등급이 2등급인 사원이 가장 많은 / 부서의 정보를 출력하시오.

--급여 등급 2등급 사원이 많은 부서 랭크
SELECT E.DEPTNO,
    RANK() OVER(ORDER BY COUNT (*) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE SG 
                            ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
                        AND SG.GRADE = 2
                        GROUP BY E.DEPTNO         
;
--하1 답
SELECT D.*
FROM DEPT D INNER JOIN ( SELECT E.DEPTNO,
                            RANK() OVER(ORDER BY COUNT (*) DESC) AS RNK
                        FROM EMP E INNER JOIN SALGRADE SG 
                            ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
                        AND SG.GRADE = 2
                        GROUP BY E.DEPTNO )E
                    ON D.DEPTNO = E.DEPTNO
                AND E.RNK =1
;

--급여 등급이 2,4등급인 사원들이 가장 많이 포함된 /부서의 업무별 급여 총 순위를 출력하시오

--급여등급 2,4 등급 사원 가장 많이 포함된 부서
SELECT E.DEPTNO, RANK() OVER ( ORDER BY COUNT(*) DESC ) AS RNK
FROM EMP E INNER JOIN SALGRADE SG
                                ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
                                AND SG.GRADE IN (2,4)
                                GROUP BY E.DEPTNO
;       

--하2 정답
--급여 등급이 2,4등급인 사원들이 가장 많이 포함된 /부서의 업무별 급여 총 순위를 출력하시오
SELECT E.ENAME, E.SAL, D.DNAME, E.JOB,
    RANK () OVER (PARTITION BY D.DEPTNO, E.JOB ORDER BY E.SAL DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                        ON E.DEPTNO = D.DEPTNO
            INNER JOIN  (SELECT E.DEPTNO, RANK() OVER ( ORDER BY COUNT(*) DESC ) AS RNK
                            FROM EMP E INNER JOIN SALGRADE SG
                                        ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
                                        AND SG.GRADE IN (2,4)
                        GROUP BY E.DEPTNO)S        
                    ON E.DEPTNO = S.DEPTNO
                    AND S.RNK =1
;

--KING을 제외한 사원들의 급여 최대치와 최소치를 구하고 그 차이를 구하여 전체 급여 평균과의 차이를 구하시오.
--최대치,최소치
SELECT MAX(SAL) - MIN(SAL) AS CHA
FROM EMP
WHERE ENAME != 'KING'
;
--평균
SELECT AVG(SAL)
FROM EMP
;
--전체급여 평균의 차이

SELECT C.CHA - A.RAVG
FROM  (
            SELECT MAX(SAL) - MIN(SAL) AS CHA
                FROM EMP
                WHERE ENAME != 'KING') C INNER JOIN (SELECT AVG(SAL) AS RAVG
                                                        FROM EMP) A
                                                ON 1=1
;

--하3 CASE, 'KING 제외 최대치 최소치
SELECT MAX( CASE WHEN ENAME = 'KING'
                    THEN NULL
                    ELSE SAL
                    END) - MIN( CASE WHEN ENAME = 'KING'
                                    THEN NULL       
                                    ELSE SAL
                                    END)- AVG(SAL)
FROM EMP
;
--난이도 중1
--이름에 'L'이 들어가는 사원이 가장 많은 업무/를 구하고 
-- 그 업무가 가장 많은 부서의 정보를 출력하시오.

SELECT JOB,COUNT(*),
    RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMP
WHERE ENAME LIKE '%L%'
GROUP BY JOB
;

SELECT E.DEPTNO,E.JOB,COUNT(*) AS CNT,
    RANK() OVER (PARTITION BY E.DEPTNO, E.JOB ORDER BY COUNT(*) DESC) AS RNK
FROM EMP E INNER JOIN (SELECT JOB,COUNT(*),
                        RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                        FROM EMP
                        WHERE ENAME LIKE '%L%'
                        GROUP BY JOB) A
                ON E.JOB = A.JOB
                AND RNK =1
        GROUP BY E.DEPTNO, E.JOB         
;
--정답 중복제거이유 다른 알바벳 중복 발생
SELECT DISTINCT D.*
FROM  DEPT D INNER JOIN (SELECT E.DEPTNO,E.JOB,COUNT(*) AS CNT,
                              RANK() OVER (PARTITION BY E.DEPTNO, E.JOB ORDER BY COUNT(*) DESC) AS RNK
                        FROM EMP E INNER JOIN (SELECT JOB,COUNT(*),
                                                RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                                                FROM EMP
                                                WHERE ENAME LIKE '%B%'
                                                GROUP BY JOB) A
                                ON E.JOB = A.JOB
                                AND RNK =1
                        GROUP BY E.DEPTNO, E.JOB) E
                ON D.DEPTNO = E.DEPTNO
                AND E.RNK =1
;


--난이도 중2
--12월에 입사자 급여순위 2등의 급여보다 
--많은 급여를 받는 사원들 중 가장 많은 사원이 있는 업무를 구하시오.

SELECT SAL, RANK() OVER (ORDER BY SAL DESC) AS RNK
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 12
;
SELECT E.JOB
FROM
        (SELECT E.JOB,COUNT(*) AS CNT,
            RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
        FROM  EMP E INNER JOIN (SELECT SAL, RANK() OVER (ORDER BY SAL DESC) AS RNK
                                FROM EMP
                                WHERE TO_CHAR(HIREDATE, 'MM') = 12 )S
                            ON E.SAL > S.SAL
                            AND S.RNK = 2
                    GROUP BY E.JOB ) E
WHERE E.RNK = 1                
;

--난이도 상 1
--입사자가 가장 많인 입사한 연도에 입사자 평균 급여를 구하고,
-- 전체사원을 대상으로 구한 평균급여보다 많이 받는 사람의 급여를 50% 삭감하여
--전체 사원의 정보를 출력하시오 

SELECT TO_CHAR(HIREDATE, 'YYYY') AS YY, AVG(SAL) AS AVG_SAL, COUNT(*) AS CNT,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
;

SELECT E.EMPNO,E.ENAME,E.JOB,E.COMM,E.DEPTNO,E.SAL,
        CASE WHEN E.SAL > A.AVG_SAL
             THEN E.SAL * 0.5
             ELSE E.SAL
        END AS RSAL
FROM EMP E INNER JOIN (SELECT TO_CHAR(HIREDATE, 'YYYY') AS YY, AVG(SAL) AS AVG_SAL, COUNT(*) AS CNT,
                             RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                        FROM EMP
                        GROUP BY TO_CHAR(HIREDATE, 'YYYY')) A
                    ON A.RNK =1

;
--배포버전

SELECT E.EMPNO,E.ENAME,E.JOB, E.COMM, E.DEPTNO, E.SAL,
        CASE WHEN E.SAL > A.AVG_SAL
             THEN  E.SAL * 0.5
             ELSE  E.SAL
        END AS RSAL
FROM EMP E INNER JOIN (SELECT TO_CHAR(HIREDATE, 'YYYY') AS YY, AVG(SAL) AS AVG_SAL, COUNT(*) AS CNT,
                            RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                        FROM EMP
                        GROUP BY TO_CHAR(HIREDATE, 'YYYY')) A
                    ON A.RNK = 1
;



--난이도 상 2
--부서별 급여 평균을 구하고/ 각각 부서의 사원들의 급여가 각각 부서별 급여평균보다 높으면 급여률 20%삭감 하여
-- 사원명,사원급여,부서평균를 출력하시오.

SELECT  DEPTNO, AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY DEPTNO
;

SELECT E.ENAME,
          CASE WHEN E.SAL > D2.AVG_SAL
                THEN E.SAL * 0.8
                ELSE E.SAL
            END AS SAL,
            D.DNAME, D2.AVG_SAL
FROM EMP E INNER JOIN DEPT D
                   ON E.DEPTNO = D.DEPTNO
            INNER JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL
                        FROM EMP 
                        GROUP BY DEPTNO )D2
                   ON D.DEPTNO = D2.DEPTNO 
;
--난이도 상 3
--NEW YORK에 업무하는 사원들의 전체 급여 평균과 그 사원들을 제외한 사원들의 급여 평균을 구하여
-- 두차이를 구하고, 구한 차이 이상의 급여를 받는 사원들의 급여를 구한차이 만큼 감봉하여 전체사원의 정보를 출력하시오.
SELECT ABS(AVG(CASE WHEN D.LOC = 'NEW YORK'
                    THEN SAL
                    ELSE NULL
                END) -
            AVG(CASE WHEN D.LOC != 'NEW YORK'
                     THEN SAL
                     ELSE NULL
                END)) AS CHA
FROM EMP E INNER JOIN DEPT D
                    ON E.DEPTNO = D.DEPTNO
;
SELECT E.EMPNO, E.ENAME, E.JOB, E.COMM, E.DEPTNO, E.SAL,
        CASE WHEN E.SAL > C.CHA
             THEN E.SAL -C.CHA
             ELSE E.SAL
        END AS RSAL
FROM EMP E INNER JOIN (SELECT ABS(ROUND(AVG(CASE WHEN D.LOC = 'NEW YORK'
                                           THEN SAL
                                           ELSE NULL
                                      END) -
                                      AVG(CASE WHEN D.LOC != 'NEW YORK'
                                               THEN SAL
                                               ELSE NULL
                                            END),2)) AS CHA
                            FROM EMP E INNER JOIN DEPT D
                                                ON E.DEPTNO = D.DEPTNO) C
                    ON 1 = 1
    ;

--마지막 문제
--급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10% 감봉하여 전체 사원의 평균을 구하고, 구한 평균이상인 사람들의
--급여를 20% 감봉하여 전체 급여순위와 사원정보를 출력하시오

SELECT AVG(CASE WHEN MOD(E.RNK,2) = 1
                THEN E.SAL * 0.9
                ELSE E.SAL
            END) AS AVG_SAL
FROM (SELECT SAL, RANK() OVER(ORDER BY SAL DESC) AS RNK
      FROM EMP ) E
;

SELECT E.EMPNO, E.ENAME, E.JOB, E.COMM, E.DEPTNO, E.SAL,
        CASE WHEN E.SAL >= A.AVG_SAL
             THEN E.SAL * 0.8
             ELSE E.SAL 
        END AS RSAL,
        RANK() OVER(ORDER BY CASE WHEN E.SAL >= A.AVG_SAL
                                    THEN E.SAL * 0.8
                                    ELSE E.SAL
                            END DESC) AS RNK
FROM EMP E INNER JOIN (SELECT AVG(CASE WHEN MOD(E.RNK,2) = 1
                                       THEN E.SAL * 0.9
                                       ELSE E.SAL
                                END) AS AVG_SAL
                                        FROM (SELECT SAL, RANK() OVER(ORDER BY SAL DESC) AS RNK
                              FROM EMP ) E) A
                        ON 1=1
;


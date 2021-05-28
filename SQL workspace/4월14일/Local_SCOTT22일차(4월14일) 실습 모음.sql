--22일차 실습
--난이도 하 
--급여등급이 2등급인 사원/이 가장 많은 부서의 정보를 출력하시오.

SELECT E.DEPTNO,COUNT(DEPTNO),SG.GRADE,
        RANK() OVER( ORDER BY COUNT(DEPTNO) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE SG
                        ON SAL BETWEEN LOSAL AND HISAL
                        AND SG.GRADE =2                       
GROUP BY E.DEPTNO, SG.GRADE
;
--2등급 사원이 가장 많은 부서 정보, 1번정답
SELECT D.*
FROM 
        (SELECT E.DEPTNO,COUNT(DEPTNO),SG.GRADE,
        RANK() OVER( ORDER BY COUNT(DEPTNO) DESC) AS RNK
        FROM EMP E INNER JOIN SALGRADE SG
                        ON SAL BETWEEN LOSAL AND HISAL
                     AND SG.GRADE =2                       
                GROUP BY E.DEPTNO, SG.GRADE) A INNER JOIN DEPT D
                        ON A.DEPTNO=D.DEPTNO
WHERE RNK =1
;         
--급여등급이 2,4등급이 사원들이 가장 많이 포함된 부서의 업무별 /급여 총순위를 출력하시오.

--2,4 등급이 가장 많이 포함된 부서
SELECT COUNT(E.DEPTNO),E.DEPTNO,
    RANK() OVER ( ORDER BY COUNT(DEPTNO) DESC) AS RNK
FROM EMP E INNER JOIN SALGRADE SG 
                                ON SAL BETWEEN LOSAL AND HISAL   
                               
WHERE SG.GRADE =2
OR SG.GRADE =4
GROUP BY E.DEPTNO
;
-- 업무별 급여 총순위, 2번 정답

SELECT D.DNAME,E2.ENAME,E2.JOB,E2.SAL,
    RANK() OVER (PARTITION BY  E.DEPTNO,E2.JOB ORDER BY E2.SAL DESC) AS RNK2
FROM 
                    (SELECT COUNT(E.DEPTNO),E.DEPTNO,
                        RANK() OVER (ORDER BY COUNT(DEPTNO) DESC) AS RNK
                    FROM EMP E INNER JOIN SALGRADE SG 
                      ON SAL BETWEEN LOSAL AND HISAL                                                              
                            WHERE SG.GRADE =2
                            OR SG.GRADE =4
                            GROUP BY DEPTNO ) E INNER JOIN EMP E2
                                    ON E.DEPTNO = E2.DEPTNO 
                                    INNER JOIN DEPT D 
                                    ON E.DEPTNO = D.DEPTNO
WHERE RNK =1  
;                
--KING을 제외한 사원들의 급여 최대치와 최소치를 구하고 그차이를 구하여 
--전체 급여 평균과의 차이를 구하시오.
--정답 --전체급여
--급여 최대치 최소치
SELECT MAX(SAL),MIN(SAL)
FROM EMP
WHERE ENAME NOT IN 'KING'
;
--전체 급여 평균
SELECT FLOOR(AVG(SAL))
FROM EMP
;
--KING을 제외한 사원들의 급여 최대치와 최소치를 구하고 그차이를 구하여 
--전체 급여 평균과의 차이를 구하시오. 3번 정답
SELECT GAP-A.FAVG
FROM 
        ( SELECT MAX(SAL)-MIN(SAL) AS GAP
            FROM EMP
            WHERE ENAME NOT IN 'KING' ) E INNER JOIN ( SELECT FLOOR(AVG(SAL)) AS FAVG
                                                                    FROM EMP) A
                                                                      ON 1 = 1
;
--난이도 중
--업무가 CLERK인 사원들의 상급자의 급여순위를 포함한 정보를 출력하시오.

--업무 CLERK 사원들 
SELECT ENAME,JOB,MGR
FROM EMP
WHERE JOB = 'CLERK'
;

SELECT EMPNO,ENAME, SAL,
 RANK () OVER (ORDER BY SAL DESC) AS RNK
FROM EMP
;

--급여순위 전체 비교 버전
SELECT *
FROM 
            ( SELECT ENAME,JOB,MGR
            FROM EMP
            WHERE JOB = 'CLERK' ) C INNER JOIN (SELECT EMPNO,ENAME, SAL,
                                             RANK () OVER (ORDER BY SAL DESC) AS RNK
                                            FROM EMP) E
                                            ON C.MGR= E.EMPNO
WHERE C.JOB = 'CLERK'
;
--급여순위 상급자끼리 비교 버전
SELECT C.ENAME,C.JOB,C.MGR,E.EMPNO,E.ENAME,E.SAL,
    RANK( ) OVER (ORDER BY E.SAL DESC ) AS RNK2
FROM 
            ( SELECT ENAME,JOB,MGR
            FROM EMP
            WHERE JOB = 'CLERK' ) C INNER JOIN (SELECT EMPNO,ENAME, SAL,
                                             RANK () OVER (ORDER BY SAL DESC) AS RNK
                                            FROM EMP) E
                                            ON C.MGR= E.EMPNO
WHERE C.JOB = 'CLERK'
;

--난이도 중
--이름에 'L'이 들어가는 사원이 가장 많은 업무/를 구하고 
-- 그 업무가 가장 많은 부서의 정보를 출력하시오.

--이름에 'L' 들어가는 사원 목록
SELECT ENAME,JOB
FROM EMP
WHERE ENAME LIKE '%L%'
;
-- 이름에 'L' 들어가는 사원 업무 순위 - > 매니저
SELECT COUNT(JOB),E.JOB,
    RANK() OVER (ORDER BY COUNT(JOB) DESC) AS RNK
FROM 
      ( SELECT ENAME,JOB
        FROM EMP
        WHERE ENAME LIKE '%L%')E
GROUP BY JOB    
;
--매니저가 가장 많은 부서 ㅋㅋ
SELECT COUNT(E2.JOB),E2.JOB,E2.DEPTNO
FROM    
        ( SELECT COUNT(JOB),E.JOB,
           RANK() OVER (ORDER BY COUNT(JOB) DESC) AS RNK
                 FROM 
              ( SELECT ENAME,JOB
                FROM EMP
                WHERE ENAME LIKE '%L%')E
                GROUP BY JOB  ) J INNER JOIN EMP E2
                                ON 1=1
WHERE RNK=1  
GROUP BY E2.JOB,E2.DEPTNO
;
-- 그 업무가 가장 많은 부서의 정보를 출력하시오. 매니저는 리서치,세일즈,어카운팅 1명씩 있음
SELECT J2.JOB,D.DNAME,D.DEPTNO,D.LOC
FROM 
        ( SELECT COUNT(E2.JOB),E2.JOB,E2.DEPTNO
            FROM    
                ( SELECT COUNT(JOB),E.JOB,
                   RANK() OVER (ORDER BY COUNT(JOB) DESC) AS RNK
                     FROM 
                  ( SELECT ENAME,JOB
                    FROM EMP
                    WHERE ENAME LIKE '%L%')E
                    GROUP BY JOB  ) J INNER JOIN EMP E2
                                    ON 1=1
                        WHERE RNK=1  
                        GROUP BY E2.JOB,E2.DEPTNO) J2 INNER JOIN DEPT D
                        ON J2.DEPTNO=D.DEPTNO
WHERE JOB = 'MANAGER'
;
--난이도 중
--12월에 입사한 사원 중 급여순위 2등의 급여보다 
--큰 사원들 중 가장 많은 사원이 있는 업무를 구하시오.

SELECT TO_CHAR(HIREDATE, 'MM') AS MM,HIREDATE,ENAME,SAL
FROM EMP
;

--12월에 입사한 사원 중 2등의 급여를 구해보자
SELECT M.ENAME, M.SAL,
   RANK() OVER (ORDER BY M.SAL DESC) AS RNK
FROM  
                (SELECT TO_CHAR(HIREDATE, 'MM')AS MM,HIREDATE,ENAME,SAL
                    FROM EMP) M 
WHERE M.MM =12 

;

--2등의급여 

SELECT *
FROM 
        ( SELECT M.ENAME, M.SAL,
            RANK() OVER (ORDER BY M.SAL DESC) AS RNK
            FROM  
                (SELECT TO_CHAR(HIREDATE, 'MM')AS MM,HIREDATE,ENAME,SAL
                    FROM EMP) M 
                WHERE M.MM =12 ) M2 
WHERE RNK =2
;
--2등의 급여보다 큰사원들 중 가장 많은 사원이 있는 업무를 구하시오.

SELECT JOB,COUNT(JOB),
    RANK ()OVER (ORDER BY COUNT(JOB) DESC) AS RNK2
FROM  
            (SELECT *
            FROM 
                     ( SELECT M.ENAME, M.SAL,
                        RANK() OVER (ORDER BY M.SAL DESC) AS RNK
                        FROM  
                          (SELECT TO_CHAR(HIREDATE, 'MM')AS MM,HIREDATE,ENAME,SAL
                           FROM EMP) M 
                             WHERE M.MM =12 ) M2 
        WHERE RNK =2 ) M3 INNER JOIN EMP 
        ON 1=1
WHERE M3.SAL < E.SAL
GROUP BY JOB
;
--난이도 상
--가장 많이 입사한 연도에 입사한 사원들의 평균 급여를 구하고, 평균급여보다 많이 받는 사람의 급여를 50% 삭감하여
--전체 사원의 정보를 출력하시오

--가장많이 입사한 연도 입사한 사원들의 평균 급여

--입사년도
SELECT TO_CHAR(HIREDATE,'YY')
FROM EMP
;
--가장 많이 입사한 연도 
SELECT  COUNT(YY),YY,
    RANK() OVER (ORDER BY COUNT(YY)DESC) AS RNKYY
FROM 
        ( SELECT TO_CHAR(HIREDATE,'YY') AS YY,HIREDATE
        FROM EMP) 
GROUP BY YY  
;
--가장 많이 입사한 연도의 평균급여

SELECT AVG(E.SAL),MYY.YY
FROM
        (SELECT  COUNT(YY),YY,
        RANK() OVER (ORDER BY COUNT(YY)DESC) AS RNKYY
        FROM 
        ( SELECT TO_CHAR(HIREDATE,'YY') AS YY,HIREDATE
        FROM EMP) 
        GROUP BY YY ) MYY INNER JOIN EMP E
                    ON MYY.YY = TO_CHAR(E.HIREDATE, 'YY')
WHERE MYY.RNKYY=1   
GROUP BY MYY.YY
;
--평균급여보다 많이 받는 사람의 급여를 50% 삭감하여
--전체 사원의 정보를 출력하시오

SELECT  E.EMPNO,E.ENAME,E.JOB,E.MGR,E.HIREDATE,E.COMM,E.DEPTNO,Y2.ASAL,E.SAL,
        CASE WHEN E.SAL > Y2.ASAL
                THEN E.SAL *0.5
                ELSE E.SAL
                END AS RSAL,
        RANK() OVER (ORDER BY  CASE WHEN E.SAL > Y2.ASAL
                THEN E.SAL *0.5
                ELSE E.SAL
                END  DESC)  AS RNK  
FROM
        ( SELECT AVG(SAL)AS ASAL,MYY.YY
        FROM
            (SELECT  COUNT(YY),YY,
            RANK() OVER (ORDER BY COUNT(YY)DESC) AS RNKYY
            FROM 
                ( SELECT TO_CHAR(HIREDATE,'YY') AS YY,HIREDATE
                FROM EMP) 
                    GROUP BY YY ) MYY INNER JOIN EMP E
                                ON MYY.YY = TO_CHAR(E.HIREDATE, 'YY')
                    WHERE MYY.RNKYY=1   
                    GROUP BY MYY.YY ) Y2 INNER JOIN EMP E
                                                ON 1=1

;



--부서별 급여 평균을 구하고/ 각각 부서의 사원들의 급여가 각각 부서별 급여평균보다 높으면 급여률 20%삭감 하여
-- 사원명,사원급여,부서평균를 출력하시오.

--부서별 평균 급여
SELECT DEPTNO,SUM(SAL),COUNT(DEPTNO),FLOOR(SUM(SAL)/COUNT(DEPTNO)) AS DAVG
FROM EMP 
GROUP BY DEPTNO
;
--20% 삭감하고 사원명,사원급여,부서평균 출력
SELECT E.ENAME,E.DEPTNO,A.DAVG,E.SAL,
    CASE WHEN E.SAL > A.DAVG
        THEN E.SAL * 0.8
        ELSE E.SAL
        END AS RSAL
FROM 
        ( SELECT DEPTNO,FLOOR(SUM(SAL)/COUNT(DEPTNO))as DAVG
            FROM EMP 
            GROUP BY DEPTNO ) A INNER JOIN EMP E
                            ON A.DEPTNO = E.DEPTNO
ORDER BY DEPTNO                            
;

--NEW YORK에 업무하는 사원들의 전체 급여 평균과 그 사원들을 제외한 사원들의 급여 평균을 구하여
-- 두차이를 구하고, 구한 차이 이상의 급여를 받는 사원들의 급여를 구한차이 만큼 감봉하여 전체사원의 정보를 출력하시오.

--NEW YORK 업무하는 사원 전체 급여 평균
SELECT FLOOR(AVG(SAL)) AS NAVG
FROM EMP E INNER JOIN DEPT D
                    ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'NEW YORK'
;

--NEW YORK에 근무하는 사원 제외한 사원 급여 평균
SELECT  FLOOR(AVG(SAL)) AS OAVG
FROM EMP E INNER JOIN DEPT D
                ON E.DEPTNO = D.DEPTNO
WHERE  D.LOC NOT IN 'NEW YORK'                
        
;
--NEW YORK 사원 급여 평균 과 제외 사원 급여 평균 차이

SELECT (N.NAVG - O.OAVG) AS GAP
FROM 
            ( SELECT FLOOR(AVG(SAL)) AS NAVG
            FROM EMP E INNER JOIN DEPT D
                ON E.DEPTNO = D.DEPTNO
                WHERE D.LOC = 'NEW YORK') N INNER JOIN (SELECT  FLOOR(AVG(SAL)) AS OAVG
                                                            FROM EMP E INNER JOIN DEPT D
                                                                ON E.DEPTNO = D.DEPTNO
                                                                WHERE  D.LOC NOT IN 'NEW YORK') O
                                                                ON  1=1

;
--구한 차이 이상의 급여를 받는 사원들의 급여를 구한차이 만큼 감봉하여 전체사원의 정보를 출력하시오.

SELECT E.EMPNO,E.ENAME,E.JOB,E.MGR,E.HIREDATE,E.SAL,NO.GAP,
    CASE WHEN E.SAL >= NO.GAP
        THEN E.SAL - NO.GAP
        ELSE E.SAL
        END AS RSAL
FROM ( SELECT (N.NAVG - O.OAVG) AS GAP 
        FROM 
            ( SELECT FLOOR(AVG(SAL)) AS NAVG
            FROM EMP E INNER JOIN DEPT D
                ON E.DEPTNO = D.DEPTNO
                WHERE D.LOC = 'NEW YORK') N INNER JOIN (SELECT  FLOOR(AVG(SAL)) AS OAVG
                                                            FROM EMP E INNER JOIN DEPT D
                                                                ON E.DEPTNO = D.DEPTNO
                                                                WHERE  D.LOC NOT IN 'NEW YORK') O
                                                                ON  1=1 ) NO INNER JOIN EMP E 
                                                                                    ON 1=1

;
--마지막 문제
--급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10% 감봉하여 전체 사원의 평균을 구하고, 구한 평균이상인 사람들의
--급여를 20% 감봉하여 전체 급여순위와 사원정보를 출력하시오

--급여 순위
SELECT ENAME,SAL,
    DENSE_RANK() OVER (ORDER BY SAL DESC) AS RNK 
FROM EMP
;

-- 홀수 번째 해당하는 전체사원 급여 10% 감봉 포함 급여순위
SELECT ENAME,RNK,
        DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
      
FROM
        ( SELECT ENAME,SAL,
            DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                FROM EMP) ODD

;

---- 홀수 번째 해당하는 전체사원 급여 10% 감봉 포함 급여순위 평균

SELECT FLOOR(AVG(RSAL)) AS RAVG
FROM 
        (SELECT ENAME,RNK, 
        DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
          FROM
            ( SELECT ENAME,SAL,
                DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                    FROM EMP)) 

;

SELECT *
FROM   (SELECT ENAME,RNK, 
        DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
          FROM
            ( SELECT ENAME,SAL,
                DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                    FROM EMP)) 

;
--급여 순위 중 홀수번째에 해당하는 사원들의 급여를 10% 감봉하여 전체 사원의 평균을 구하고, 구한 평균이상인 사람들의
--급여를 20% 감봉하여 전체 급여순위와 사원정보를 출력하시오

--선생님의 말씀 으로 인해 감봉 OF 감봉 버전
SELECT E.EMPNO,E.JOB,E.MGR,E.HIREDATE,E.COMM,E.DEPTNO,A2.*,
        CASE WHEN A2.RSAL > AVG.RAVG
            THEN A2.RSAL * 0.8
            ELSE SAL
            END AS RRSAL
FROM
        (SELECT FLOOR(AVG(RSAL)) AS RAVG
        FROM 
            (SELECT ENAME,RNK, 
            DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
          FROM
            ( SELECT ENAME,SAL,
                DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                    FROM EMP))) AVG INNER JOIN (SELECT *
                                                FROM  (SELECT ENAME,RNK, 
                                                DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
                                                  FROM
                                                    ( SELECT ENAME,SAL,
                                                        DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                                                            FROM EMP))) A2
                                                            ON 1 = 1 INNER JOIN EMP E
                                                                    ON A2.ENAME =E.ENAME
                                                                    
;
--올바른 버전

SELECT E.*,A.RAVG,
        CASE WHEN E.SAL > A.RAVG
                THEN E.SAL * 0.8
                ELSE E.SAL
                END AS RSAL,
    RANK() OVER (ORDER BY  CASE WHEN E.SAL > A.RAVG
                THEN E.SAL * 0.8
                ELSE E.SAL
                END DESC) AS RRNK
FROM
            (
                SELECT FLOOR(AVG(RSAL)) AS RAVG
                FROM 
        (SELECT ENAME,RNK, 
        DECODE(MOD(RNK,2), 1, SAL * 0.9, SAL) AS RSAL
          FROM
            ( SELECT ENAME,SAL,
                DENSE_RANK () OVER (ORDER BY SAL DESC) AS RNK 
                    FROM EMP))) A INNER JOIN EMP E
                                                ON 1=1
;
SELECT MAX(SAL) - MIN(SAL)
FROM EMP
WHERE ENAME LIKE '%A%'
;
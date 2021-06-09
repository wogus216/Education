--4월 19일 SCOTT 우리 끼리 실습문제


--[유통 물류]
-- 연봉이 1등급인 사원들의 매니저 이름과 해당 매니저들의 연봉 순위를 출력하시오.

SELECT *
FROM EMP E INNER JOIN SALGRADE SG
                        ON E.SAL BETWEEN LOSAL AND HISAL
                        AND SG.GRADE = 1
;

SELECT E.ENAME,E.SAL,
    RANK() OVER(ORDER BY E.SAL DESC) AS RNK
FROM EMP E INNER JOIN (SELECT *
                        FROM EMP E INNER JOIN SALGRADE SG
                        ON E.SAL BETWEEN LOSAL AND HISAL
                        AND SG.GRADE = 1) M 
                    ON E.EMPNO = M.MGR
;
--금융
-- 직업별로 최소 급여를 받는 사원들 중 제일 작은 사원의 급여를 30%인상 후 적용된 급여를 나타내시오. 
-- 사원번호, 이름, 업무, 부서명, 적용 급여

SELECT JOB,MIN(SAL)AS M_SAL,
        RANK() OVER (ORDER BY MIN(SAL) ASC) AS RNK 
FROM EMP
GROUP BY JOB
;


SELECT E.EMPNO,E.ENAME,E.JOB,E.DEPTNO,(M.M_SAL*1.3) AS RSAL
FROM EMP E INNER JOIN (SELECT JOB,MIN(SAL)AS M_SAL,
                            RANK() OVER (ORDER BY MIN(SAL) ASC) AS RNK 
                        FROM EMP
                        GROUP BY JOB) M 
                    ON E.SAL = M.M_SAL
                    AND M.RNK = 1
;

--서비스2
-- 이름에 L이나 O가 들어가는 사람들의 상여급 평균이/ 전체 사원들의 상여급 평균보다 적을경우
-- DALLAS에 있는 직원들중 4월 입사자만 급여를 10% 인상해서 전체 사원들의 정보를 출력하시오
--LO 상여금 평균
SELECT AVG(COMM) AS LO_COMM
FROM EMP
WHERE ENAME LIKE '%L%' OR ENAME LIKE '%O%'
;
--전체사원 상여금 평균
SELECT AVG(COMM) AS AVG_COMM
FROM EMP
;

SELECT *
FROM EMP E INNER JOIN DEPT D
                        ON E.DEPTNO = D.DEPTNO
                        AND D.LOC = 'DALLAS'
                        AND TO_CHAR(HIREDATE, 'MM') = 4
;

SELECT *
FROM(  SELECT AVG(COMM) AS AVG_COMM
        FROM EMP) A INNER JOIN (SELECT AVG(COMM) AS LO_COMM
                                FROM EMP
                                WHERE ENAME LIKE '%L%' OR ENAME LIKE '%O%') LO
                    ON 1 = 1
;


SELECT E.*,
        DECODE(TO_CHAR(HIREDATE, 'MM'), 4, CASE WHEN B.AVG_COMM > B.LO_COMM
                                                THEN E.SAL * 1.1
                                                ELSE E.SAL
                                                END, E.SAL )AS RSAL
FROM EMP E INNER JOIN (SELECT *
FROM(  SELECT AVG(COMM) AS AVG_COMM
        FROM EMP) A INNER JOIN (SELECT AVG(COMM) AS LO_COMM
                                FROM EMP
                                WHERE ENAME LIKE '%L%' OR ENAME LIKE '%O%') LO
                    ON 1 = 1) B
                 ON   1=1
;

--공공1
-- 커미션을 포함한 전체사원의 평균급여를 (소수점 첫번째까지 반올림하여) 구하고 /구해진 평균급여보다
-- 높은급여를 받는 사원의 상급자 월급을 20%감봉한뒤, 상급자 이름, 변경된 상급자급여와 순위를 출력하시오

SELECT ROUND(AVG(SAL+COMM),1) AS RAVG
FROM EMP
;

SELECT CASE WHEN E.SAL > A.RAVG
            THEN E.ENAME
            ELSE NULL
            END AS R,E.SAL,E.MGR,E.EMPNO
FROM EMP E INNER JOIN (SELECT ROUND(AVG(SAL+NVL(COMM,0)),1) AS RAVG
                       FROM EMP) A
                    ON 1 = 1
                       
;

SELECT DISTINCT E.ENAME,E.MGR,E.EMPNO
FROM EMP E   INNER JOIN (SELECT CASE WHEN E.SAL > A.RAVG
                                     THEN E.ENAME
                                     ELSE NULL
                                     END AS R,E.SAL,E.MGR
                        FROM EMP E 
             INNER JOIN (SELECT ROUND(AVG(SAL+NVL(COMM,0)),1) AS RAVG
                        FROM EMP) A
                        ON 1 = 1)A2    
                ON E.EMPNO = A2.MGR
;
--서비스1
-- DALLAS 지역에 사는 직원의 커미션을 (급여+커미션)의 10퍼센트주고 반올림한 급여(커미션포함) 1,2,3등구하기(DALLAS 지역에 사는 사람 중)
-- 출력 : 이름, 급여, 순위
SELECT *
FROM   (SELECT E.ENAME,((E.SAL+NVL(COMM,0))*1.1) AS RSAL,
                       DENSE_RANK() OVER (ORDER BY ((E.SAL+NVL(COMM,0))*1.1) DESC) AS RNK
        FROM DEPT D INNER JOIN EMP E 
                            ON D.DEPTNO = E.DEPTNO
                            AND D.LOC = 'DALLAS') R
WHERE R.RNK <=3
;

--공공2
-- 커미션을 포함한 평균급여가 가장 높은 지역의 급여를 30%삭감, 
-- 가장 낮은 지역에 30% 인상 한 뒤 가장 높은 평균급여를 받는 부서를 구하시오.

SELECT D.LOC,AVG(SAL+NVL(COMM,0)) AS RAVG,D.DEPTNO,D.DNAME,
        RANK() OVER (ORDER BY AVG(SAL+NVL(COMM,0)) DESC) AS RNK 
FROM EMP E INNER JOIN DEPT D
                ON E.DEPTNO = D.DEPTNO
GROUP BY D.LOC,D.DEPTNO,D.DNAME
;


SELECT E.ENAME,E.DEPTNO,N.LOC,(CASE WHEN N.RNK = 1 
                               THEN E.SAL * 0.7
                               WHEN N.RNK = 3
                               THEN E.SAL * 1.3
                               ELSE E.SAL
                               END )AS RSAL,N.DNAME
FROM EMP E INNER JOIN (SELECT D.LOC,AVG(SAL+NVL(COMM,0)) AS RAVG,D.DEPTNO,D.DNAME,
                            RANK() OVER (ORDER BY AVG(SAL+NVL(COMM,0)) DESC) AS RNK 
                       FROM EMP E 
           INNER JOIN DEPT D
                      ON E.DEPTNO = D.DEPTNO
        GROUP BY D.LOC,D.DEPTNO,D.DNAME)  N
       ON E.DEPTNO = N.DEPTNO
 ;       
SELECT *
FROM
        (SELECT N2.LOC,AVG(N2.RSAL),N2.DEPTNO,N2.DNAME,
                RANK() OVER (ORDER BY AVG(N2.RSAL) DESC) AS RNK
        FROM (SELECT E.ENAME,E.DEPTNO,N.LOC, (CASE WHEN N.RNK = 1 
                                       THEN E.SAL * 0.7
                                       WHEN N.RNK = 3
                                       THEN E.SAL * 1.3
                                       ELSE E.SAL
                                       END )AS RSAL,N.DNAME
        FROM EMP E INNER JOIN (SELECT D.LOC,AVG(SAL+NVL(COMM,0)) AS RAVG,D.DEPTNO,D.DNAME,
                                    RANK() OVER (ORDER BY AVG(SAL+NVL(COMM,0)) DESC) AS RNK 
                               FROM EMP E 
                   INNER JOIN DEPT D
                              ON E.DEPTNO = D.DEPTNO
                GROUP BY D.LOC,D.DEPTNO,D.DNAME)  N
               ON E.DEPTNO = N.DEPTNO) N2
        GROUP BY N2.LOC,N2.DEPTNO,N2.DNAME ) D
    WHERE D.RNK = 1
;


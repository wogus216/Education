--20일차 JOIN

--별칭 : E,D
--ASC는 오름차순
SELECT *
FROM EMP E INNER JOIN DEPT D
                         ON E.DEPTNO = D.DEPTNO
ORDER BY E.EMPNO ASC, D.DEPTNO ASC
;

 --SAL 범위
 --자가참조사용 SAL
 SELECT * 
 
 FROM EMP E INNER JOIN SALGRADE SG
         ON E.SAL BETWEEN SG.LOSAL AND SG. HISAL
 ;
 
 --간접참조
SELECT E1.ENAME AS 부하직원, E1.MGR, E2.EMPNO, E2.ENAME AS 상급자
FROM EMP E1 INNER JOIN EMP E2
--                      ON 1 = 1
                      ON E1.MGR = E2.EMPNO
;



---사원의 부서명과 급여등급을 출력하시오.
--직접참조사용
SELECT E.ENAME,D.DNAME,SG.GRADE
FROM EMP E INNER JOIN DEPT D
                    ON E.DEPTNO = D.DEPTNO
            INNER JOIN SALGRADE SG
                ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
;


--문제
--시카고에 근무하는 사원들의 / 급여순위를 구하시오.
SELECT E.ENAME,E.SAL, D.LOC,
    RANK() OVER (ORDER BY SAL  DESC) AS RNK
FROM EMP E INNER JOIN DEPT D
                        ON E.DEPTNO = D.DEPTNO
                        AND D.LOC= 'CHICAGO'
;

--급여 등급이 2등급인 사원들/ 중 부서별 급여 1위를 구하시오.   
SELECT ENAME,D.DNAME, E.SAL, SAL.GRADE,
  RANK() OVER( PARTITION BY D.DEPTNO ORDER BY SAL DESC ) AS RNK
FROM EMP E INNER JOIN SALGRADE SAL
                            ON E.SAL BETWEEN LOSAL AND HISAL
                            AND SAL.GRADE =2
                            INNER JOIN  DEPT D
                            ON E.DEPTNO = D.DEPTNO
;

--급여 등급이 2등급인 사원들/ 중 부서별 급여 1위를 구하시오.  
SELECT *
FROM
        ( SELECT E.ENAME, E.SAL,D.DNAME,SG.GRADE,
            RANK() OVER( PARTITION BY DNAME ORDER BY SAL DESC) AS RNK
                        FROM EMP E INNER JOIN DEPT D 
                                ON E.DEPTNO = D.DEPTNO
                                    INNER JOIN SALGRADE SG
                                    ON SG.GRADE = 2
                                    AND E.SAL BETWEEN LOSAL AND HISAL)

;                                   

SELECT E.ENAME ,E.SAL, D.DNAME,
        RANK() OVER( PARTITION BY DNAME ORDER BY SAL) AS RNK
FROM EMP E INNER JOIN DEPT D 
                            ON E.DEPTNO= D.DEPTNO
;


--붙인 순서대로 나온다 
     SELECT E.ENAME, E.SAL, SG.GRADE, D.DNAME, 
     RANK() OVER(PARTITION BY D.DEPTNO ORDER BY E.SAL DESC) AS RNK
       FROM SALGRADE SG INNER JOIN EMP E
         ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
            INNER JOIN DEPT D 
      ON D.DEPTNO = E.DEPTNO AND SG.GRADE = 2;
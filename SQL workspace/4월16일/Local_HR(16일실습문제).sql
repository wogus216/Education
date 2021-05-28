--4월 16일 HR실습

--난이도 하
--부하직원이 가장 많은 상급자를 구하시오

--부하 직원이 가장 많은 상급자

SELECT MANAGER_ID,COUNT(*),
    RANK () OVER (ORDER BY COUNT(*) DESC ) AS RNK
FROM EMPLOYEES
GROUP BY MANAGER_ID
;


SELECT E.*
FROM (SELECT MANAGER_ID,COUNT(*),
        RANK () OVER (ORDER BY COUNT(*) DESC ) AS RNK
        FROM EMPLOYEES
        GROUP BY MANAGER_ID) M INNER JOIN EMPLOYEES E
                            ON M.MANAGER_ID = E.EMPLOYEE_ID 
WHERE RNK = 1    
;
--난이도 중
--업무나 부서 변동이 있었던 사원들의 급여평균을 구하시오.

--변동있던 사원 중복제거
SELECT DISTINCT E.EMPLOYEE_ID 
FROM EMPLOYEES E INNER JOIN JOB_HISTORY J
                        ON E.EMPLOYEE_ID = J.EMPLOYEE_ID 
                                              
;

SELECT ROUND(AVG(E2.SALARY),2)
FROM EMPLOYEES E2 INNER JOIN (SELECT DISTINCT E.EMPLOYEE_ID
                            FROM EMPLOYEES E INNER JOIN JOB_HISTORY J
                                ON E.EMPLOYEE_ID = J.EMPLOYEE_ID ) J2
                 ON E2.EMPLOYEE_ID = J2.EMPLOYEE_ID
;
--난이도 상 
--사원수 1,2등인 부서들의 급여 평균을 구하고, 그 평균의 차이를 구하시오.

--사원수 1,2등 부서

SELECT E.DEPARTMENT_ID,COUNT(*),AVG(E.SALARY),
 RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                             ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      GROUP BY   E.DEPARTMENT_ID 
;


SELECT ABS( AVG(CASE WHEN D2.RNK =1
            THEN E2.SALARY
            ELSE NULL
            END ) -  AVG( CASE WHEN D2.RNK =2
                        THEN E2.SALARY
                        ELSE NULL
                        END)) AS RESULT
FROM EMPLOYEES E2 INNER JOIN (SELECT E.DEPARTMENT_ID,COUNT(*),
                             RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                                 FROM EMPLOYEES E 
                                 INNER JOIN DEPARTMENTS D 
                                    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                     GROUP BY   E.DEPARTMENT_ID ) D2
                            ON E2.DEPARTMENT_ID = D2.DEPARTMENT_ID                                                                          
;


--간단한 버전 도전
SELECT MAX(AVG_SAL) - MIN(AVG_SAL) AS CHA
FROM   (  SELECT E.DEPARTMENT_ID,AVG(SALARY) AS AVG_SAL,
                 RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
        FROM EMPLOYEES E 
        GROUP BY E.DEPARTMENT_ID ) E
WHERE E.RNK IN (1,2)
;